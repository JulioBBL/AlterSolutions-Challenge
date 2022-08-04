//
//  PokemonDetailsViewController.swift
//  PokéChallenge
//
//  Created by Julio Brazil on 30/07/22.
//

import UIKit
import SDWebImage

class PokemonDetailsViewController: UIViewController {
    private var pokemonID: Int?
    private var pokemonModel: PokemonModel?
    private var evolutionModel: EvolutionModel?

    private lazy var scrollableStack: ScrollableStackView = {
        let view = ScrollableStackView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var pokeCardView: PokemonCardView = {
        let view = PokemonCardView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var pokeInformationSelector: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["About", "Evolutions"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.isEnabled = false

        segmented.setEnabled(false, forSegmentAt: 1)
        segmented.addTarget(self, action: #selector(PokemonDetailsViewController.handleSegmentControlChange(_:)), for: .valueChanged)

        return segmented
    }()

    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.stopAnimating()

        return view
    }()

    private lazy var evolutionView: EvolutionGraphView = {
        let view = EvolutionGraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.isHidden = true

        return view
    }()

    private lazy var aboutView: PokemonAboutView = {
        let view = PokemonAboutView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var hidableViews: [UIView] = [
        self.aboutView,
        self.evolutionView
    ]

    init(pokemonWithID pokeID: Int) {
        super.init(nibName: nil, bundle: nil)
        self.title = "#\(pokeID)"
        self.pokemonID = pokeID

        setupForLoading(pokemonWithID: pokeID)
        RequestHandler.makeRequest(.getPokemonDetai(pokeID: pokeID), expection: PokemonResponse.self) { [weak self] result in
            do {
                let viewModel = PokemonModel(from: try result.get())
                self?.setupWith(viewModel)
                self?.loadEvolutions()
            } catch {
                self?.setupForError(error)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func loadEvolutions() {
        guard let pokeID = self.pokemonID else { return }
        RequestHandler.makeRequest(.getPokemonSpecies(pokeID: pokeID), expection: SpeciesResponse.self) { [weak self] speciesResult in
            do {
                let answer = try speciesResult.get()
                guard let _chainID = answer.evolutionChain.urlLastComponent, let chainID = Int(_chainID)  else { return }
                RequestHandler.makeRequest(.getEvolutionChain(evolutionChainID: chainID), expection: EvolutionChainResponse.self) { [weak self] evolutionResult in
                    do {
                        let evolutionChainResponse = try evolutionResult.get()
                        guard let evolutionModel = EvolutionModel.from(evolutionChainResponse.chain) else { return }

                        self?.setupEvolution(evolutionModel)
                    } catch {
                        self?.setupForError(error)
                    }
                }
            } catch {
                self?.setupForError(error)
            }
        }
    }

    func setupWith(_ viewmodel: PokemonModel) {
        self.pokemonModel = viewmodel

        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.pokeCardView.setupWith(viewmodel)
            self.pokeInformationSelector.isEnabled = true

            self.aboutView.setupWith(viewmodel)
            self.scrollableStack.internalStack.addArrangedSubview(self.aboutView)
            self.pokeInformationSelector.selectedSegmentIndex = 0
        }
    }

    private func setupForLoading(pokemonWithID pokeID: Int) {
        DispatchQueue.main.async {
            self.pokeCardView.setupWith(PokemonListingModel(id: pokeID, name: "Loading"))
        }
    }

    private func setupForError(_ error: Error) {
        DispatchQueue.main.async {
            self.pokeCardView.setupWith(PokemonListingModel(id: -1, name: "Error"))
        }
    }

    private func setupEvolution(_ evolutionModel: EvolutionModel) {
        self.evolutionModel = evolutionModel

        DispatchQueue.main.async {
            self.evolutionView.configureWith(viewModel: evolutionModel)

            self.scrollableStack.internalStack.addArrangedSubview(self.evolutionView)
            self.scrollableStack.layoutIfNeeded()

            self.pokeInformationSelector.setEnabled(true, forSegmentAt: 1)
        }
    }

    @objc private func handleSegmentControlChange(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex

        UIView.animate(withDuration: 0.15, delay: .zero, options: .curveEaseIn) {
            self.hidableViews.forEach { view in
                view.alpha = 0
            }
        } completion: { _ in
            self.hidableViews.forEach { view in
                view.isHidden = true
            }

            self.hidableViews[selectedIndex].isHidden = false
            UIView.animate(withDuration: 0.15, delay: .zero, options: .curveEaseOut) {
                self.hidableViews[selectedIndex].alpha = 1
            }
        }



    }

    private func setupUI(){
        setupViewHierarchy()
        setupConstraints()
        setupAditional()
    }

    private func setupViewHierarchy() {
        self.view.addSubview(self.scrollableStack)
        self.view.addSubview(self.loader)
        self.scrollableStack.internalStack.addArrangedSubview(self.pokeCardView)
        self.scrollableStack.internalStack.addArrangedSubview(self.pokeInformationSelector)
    }

    private func setupConstraints() {
        let constraints = [
            self.scrollableStack.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollableStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollableStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollableStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            self.loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupAditional() {
        self.view.backgroundColor = .systemBackground
        self.pokeInformationSelector.isEnabled = false
        self.view.clipsToBounds = true
    }
}
