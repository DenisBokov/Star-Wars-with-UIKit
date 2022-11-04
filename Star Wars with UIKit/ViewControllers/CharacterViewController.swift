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
        
        setupNavigationBar()
        fechDataForAllCharacters()
      
    }
    
    private func setupNavigationBar() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
//        let customViewNext = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//        customViewNext.text = "Next"
//        customViewNext.textAlignment = .center
//        customViewNext.backgroundColor = .lightGray
//        customViewNext.layer.cornerRadius = 10
//        customViewNext.layer.masksToBounds = true
//
//        let customViewBack = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//        customViewNext.text = "Back"
//        customViewNext.textAlignment = .center
//        customViewNext.backgroundColor = .lightGray
//        customViewNext.layer.cornerRadius = 10
//        customViewNext.layer.masksToBounds = true
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "arrowshape.forward.fill"),
                style: .done,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "arrowshape.backward.fill"),
                style: .done,
                target: self,
                action: nil
            )
        ]
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
        
        let image = Image.allCases

        image.forEach { image in
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
    private func fechDataForAllCharacters() {
        NetworkManager.shared.fetch(PeopleStarWars.self, from: "https://swapi.dev/api/people/?page=2") { [weak self] result in
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
    case imageANewHope = "A New Hope"
    case imageAttackOfTheClones = "Attack of the Clones"
    case imageReturnOfTheJedi = "Return of the Jedi"
    case imageRevengeOfTheSith = "Revenge of the Sith"
    case imageTheEmpireStrikesBack = "The Empire Strikes Back"
    case imageThePhantomMenace = "The Phantom Menace"
}
    
    

