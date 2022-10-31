//
//  CharacterViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    var navigationTitle: String!
    
    // MARK: - Private property
    
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
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
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
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        characterTabaleView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.characterReuseId)
        characterTabaleView.dataSource = self
        characterTabaleView.delegate = self
        
        if navigationTitle == "Characters" {
            fechDataForAllCharacters()
        } else if navigationTitle == "Films" {
            fechDataForAllFilms()
        }
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
//        characters.count
        var count: Int = 0
        
        if navigationTitle == "Characters" {
             count = characters.count
        } else if navigationTitle == "Films" {
            count =  films.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.characterReuseId,
            for: indexPath) as? CharacterCell
        else {
            return UITableViewCell()
            
        }
        
        let image = Image.allCases

//        image.forEach { image in
//            if characters[indexPath.row].name == image.rawValue {
//                cell.characterImage.image = UIImage(named: image.rawValue)
//            }
//        }
        
        if navigationTitle == "Characters" {
            cell.characterNameLabel.text = characters[indexPath.row].name
//            cell.characterImage.image = UIImage(named: "people")
            image.forEach { image in
                if characters[indexPath.row].name == image.rawValue {
                    cell.characterImage.image = UIImage(named: image.rawValue)
                }
            }
        } else if navigationTitle == "Films" {
            cell.characterNameLabel.text = films[indexPath.row].title
//            cell.characterImage.image = UIImage(named: "people")
            image.forEach { image in
                if characters[indexPath.row].name == image.rawValue {
                    cell.characterImage.image = UIImage(named: image.rawValue)
                }
            }
        }
//        cell.characterNameLabel.text = characters[indexPath.row].name
        
        return cell
    }
}

// MARK: - Networking

extension CharacterViewController {
    private func fechDataForAllCharacters() {
        NetworkManager.shared.fetch(PeopleStarWars.self, from: Link.characterLink.rawValue) { [weak self] result in
            switch result {
            case .success(let jsonCharacter):
                self?.characters = jsonCharacter.results
                self?.activityIndicator.stopAnimating()
                self?.characterTabaleView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fechDataForAllFilms() {
        NetworkManager.shared.fetch(FilmStarWars.self, from: Link.filmsLink.rawValue) { [weak self] result in
            switch result {
            case .success(let jsonFilms):
                self?.films = jsonFilms.results
                self?.activityIndicator.stopAnimating()
                self?.characterTabaleView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

enum Image: String, CaseIterable {
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
}
    
    

