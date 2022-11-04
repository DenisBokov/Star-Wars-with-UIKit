//
//  CharacterViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    // MARK: - Public property
    
    var navigationTitle: String!
    
    // MARK: - Private property
    
    private var peopleStarWars: PeopleStarWars?
    private var characters: [Character] = []
    private var films: [Film] = []
    private let characterTabaleView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.startAnimating()
        return activityView
    }()
    
    // MARK: - Override UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        setupNavigationBar()
        fechDataForAllCharacters(with: Link.characterLink.rawValue)
        setupTableView()
      
    }
    
    //MARK: - Private function
    
    private func setupTableView() {
        characterTabaleView.rowHeight = 100
        
        view.addSubview(characterTabaleView)
        view.addSubview(activityIndicator)
        characterTabaleView.showsVerticalScrollIndicator = false
        characterTabaleView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            characterTabaleView.topAnchor.constraint(equalTo: view.topAnchor),
            characterTabaleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTabaleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterTabaleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        characterTabaleView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.characterReuseId)
        characterTabaleView.dataSource = self
        characterTabaleView.delegate = self
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "arrowshape.forward"),
                style: .done,
                target: self,
                action: #selector(goToNextPage)
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "arrowshape.backward"),
                style: .done,
                target: self,
                action: #selector(backToPage)
            )
        ]
    }
    
    @objc private func goToNextPage() {
        activityIndicator.startAnimating()
        fechDataForAllCharacters(with: peopleStarWars?.next)
    }
    
    @objc private func backToPage() {
        activityIndicator.startAnimating()
        fechDataForAllCharacters(with: peopleStarWars?.previous)
    }
}

// MARK: - UITableViewDelegate

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterRow = characters[indexPath.row]
        let characterInfoViewController = CharacterInfoViewController()
        characterInfoViewController.character = characterRow
        navigationController?.pushViewController(characterInfoViewController, animated: true)
        characterTabaleView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.characterReuseId,
            for: indexPath) as? CharacterCell
        else {
            return UITableViewCell()
        }
        
        ImageStarWars.allCases.forEach { image in
            if characters[indexPath.row].name == image.rawValue {
                cell.characterImage.image = UIImage(named: image.rawValue)
            }
        }
        
        cell.characterNameLabel.text = characters[indexPath.row].name
        
        return cell
    }
}

// MARK: - Networking

extension CharacterViewController {
    private func fechDataForAllCharacters(with url: String?) {
        NetworkManager.shared.fetch(PeopleStarWars.self, from: url) { [weak self] result in
            switch result {
            case .success(let jsonCharacter):
                self?.peopleStarWars = jsonCharacter
                self?.characters = jsonCharacter.results
                self?.activityIndicator.stopAnimating()
                self?.characterTabaleView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

enum ImageStarWars: String, CaseIterable {
    case imageLeiaOrgana = "Leia Organa"
    case imageC3PO = "C-3PO"
    case imageLuke = "Luke Skywalker"
    case imageR2D2 = "R2-D2"
    case imageDarthVader = "Darth Vader"
    case imageOwenLars = "Owen Lars"
    case imageBeruWhitesunLars = "Beru Whitesun lars"
    case imageR5D4 = "R5-D4"
    case imageBiggsDarklighter = "Biggs Darklighter"
    case imageObiWanKenobi = "Obi-Wan Kenobi"
    case imageANewHope = "A New Hope"
    case imageAttackOfTheClones = "Attack of the Clones"
    case imageReturnOfTheJedi = "Return of the Jedi"
    case imageRevengeOfTheSith = "Revenge of the Sith"
    case imageTheEmpireStrikesBack = "The Empire Strikes Back"
    case imageThePhantomMenace = "The Phantom Menace"
    case imageAnakinSkywalker = "Anakin Skywalker"
    case imageWilhuffTarkin = "Wilhuff Tarkin"
    case imageChewbacca = "Chewbacca"
    case imageHanSolo = "Han Solo"
    case imageGreedo = "Greedo"
    case imageJabbaDesilijicTiure = "Jabba Desilijic Tiure"
    case imageWedgeAntilles = "Wedge Antilles"
    case imageJekTonoPorkins = "Jek Tono Porkins"
    case imageYoda = "Yoda"
    case Palpatine = "Palpatine"
}
    
    

