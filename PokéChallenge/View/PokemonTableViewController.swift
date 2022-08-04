//
//  PokemonTableViewController.swift
//  PokeChallenge
//
//  Created by Julio Brazil on 31/07/22.
//

import UIKit

class PokemonTableViewController: UITableViewController, LoaderDelegate {
    private let dataSource = PokemonPrefetchingDatasource()
    
    private lazy var backgroundView: EmptyTableBackgroundView = EmptyTableBackgroundView(textForEmpty: "There are no Pokémons here, odd...")
    
    convenience init() {
        self.init(style: .grouped)
        
        self.title = "Pokémon List"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 200
        self.tableView.dataSource = dataSource as UITableViewDataSource
        self.tableView.prefetchDataSource = dataSource as UITableViewDataSourcePrefetching
        self.tableView.delegate = self
        self.tableView.backgroundView = backgroundView
        self.tableView.contentInsetAdjustmentBehavior = .scrollableAxes
        
        self.view.backgroundColor = .systemBackground

        self.dataSource.delegate = self
        self.dataSource.tableView(self.tableView, prefetchRowsAt: (0...10).map({ IndexPath(row: $0, section: .zero) })) //triggers prefetch of the first few rows
        
        definesPresentationContext = true
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showId = self.dataSource.pokemonID(for: indexPath)
        
        self.navigationController?.pushViewController(PokemonDetailsViewController(pokemonWithID: showId), animated: true)
    }
    
    // MARK: - LoaderDelegate
    @MainActor func hasStartedLoading() {
        self.backgroundView.isLoading = true
    }
    
    @MainActor func hasFinishedLoading() {
        self.backgroundView.isLoading = false
        self.tableView.reloadData()
    }
}
