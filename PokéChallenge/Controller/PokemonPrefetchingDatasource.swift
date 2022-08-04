//
//  PokemonPrefetchingDatasource.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 01/08/22.
//

import UIKit

protocol LoaderDelegate {
    @MainActor func hasStartedLoading()
    @MainActor func hasFinishedLoading()
}

class Page: Comparable, Equatable {
    let pageNumber: Int
    var isLoading: Bool = true
    var pageElements: [Resource]

    init(pageNumber: Int, isLoading: Bool, pageElements: [Resource] = []) {
        self.pageNumber = pageNumber
        self.isLoading = isLoading
        self.pageElements = pageElements
    }

    static func < (lhs: Page, rhs: Page) -> Bool {
        return lhs.pageNumber < rhs.pageNumber
    }

    static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.pageNumber == rhs.pageNumber
    }
}


class PaginationManager {
    static let PAGE_SIZE: Int = 250

    var pages: [Page] = []
    var delegate: LoaderDelegate?

    var allElements: [PokemonListingModel] {
        pages.sorted().flatMap({ $0.pageElements }).enumerated().map { index, element in
            PokemonListingModel(id: index + 1, name: element.name ?? "")
        }
    }

    func needsToLoad(page newPageNumber: Int) -> Bool {
        guard let page = self.pages.first(where: { $0.pageNumber == newPageNumber }) else { return true }
        return !page.isLoading && page.pageElements.isEmpty
    }

    func pageNumber(forElementIn indexPath: IndexPath) -> Int {
        var expectedElementRow = indexPath.row
        let elementsAlreadyLoaded = self.allElements.count

        if expectedElementRow < elementsAlreadyLoaded {
            // this code isn't expected to be executed many times in the current behaviour, but correct expected implementation is provided nonetheless
            for page in pages {
                expectedElementRow = expectedElementRow - page.pageElements.count

                if expectedElementRow < 0 {
                    return page.pageNumber
                }
            }

            return .zero
        } else {
            // accounts for quirky API behaviour, since every page wont necessarily have 250 elements
            expectedElementRow = expectedElementRow - elementsAlreadyLoaded
            return Int(expectedElementRow / PaginationManager.PAGE_SIZE) + pages.count
        }
    }
}

class PokemonPrefetchingDatasource: NSObject, UITableViewDataSource, UITableViewDataSourcePrefetching {
    private var paginationManager = PaginationManager()
    private var elementsForSearch = [PokemonModel]()
    private var pokemonTotal: Int = .zero

    public var delegate: LoaderDelegate?

    enum State {
        case showListing
        case searching
        case loadingSearch
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // since the API doesn't say how many indexed series it has, I'll be using an arbritarly large number, which is 100% not the right way to do it.
        let numberOfRows = pokemonTotal

        tableView.backgroundView?.isHidden = !(numberOfRows == 0)

        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PokemonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell

        if let model = paginationManager.allElements[safe: indexPath.row] {
            cell.configureWith(viewModel: model)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let expectedPages = Set(indexPaths.map({ paginationManager.pageNumber(forElementIn: $0) }))

        guard expectedPages.map({ self.paginationManager.needsToLoad(page: $0) }).contains(true) else {
            return
        } // make sure we don't have / aren't already loading the requested page

        self.paginationManager.pages.append(contentsOf: expectedPages.map({ Page(pageNumber: $0, isLoading: true, pageElements: []) }))

        expectedPages.forEach { [weak tableView] pageToLoad in
            RequestHandler.makeRequest(
                .getPokemonList(
                    startingFrom: paginationManager.allElements.count,
                    amount: PaginationManager.PAGE_SIZE
                ),
                expection: PokemonListResponse.self
            ) { [weak tableView, weak self] result in
                guard let self = self else { return }
                guard let page = self.paginationManager.pages.first(where: { $0.pageNumber == pageToLoad }) else { return }

                switch result {
                case let .success(listResponse):
                    self.pokemonTotal = listResponse.count
                    page.pageElements = listResponse.results
                case let .failure(error):
                    //TODO: alert user that an error has occured or implement retry mechanism
                    print("⚠️", error)
                }

                DispatchQueue.main.async {
                    if let _visibleRows = tableView?.indexPathsForVisibleRows {
                        let visibleRows = Set(_visibleRows)
                        let intersection = Set(indexPaths).intersection(visibleRows)
                        if intersection.count > 0 {
                            tableView?.reloadRows(at: Array(intersection), with: .fade)
                        } else if _visibleRows.isEmpty {
                            tableView?.reloadData()
                        }
                    }
                }

                page.isLoading = false
            }
        }
    }

    func pokemonID(for indexPath: IndexPath) -> Int {
        return self.paginationManager.allElements[indexPath.row].id
    }
}

