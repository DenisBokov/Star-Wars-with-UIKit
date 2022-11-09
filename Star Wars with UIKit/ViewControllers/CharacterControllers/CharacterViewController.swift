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
    private let characterTabaleView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.startAnimating()
        return activityView
    }()
    private let characterNames = ImageData.characterNames
    
    // MARK: - Override UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        setupNavigationBar()
        fechDataForAllCharacters(with: Link.characterLink.rawValue)
        setupTableView()
      
    }
    
    //MARK: - Private methods
    
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
        
        characterTabaleView.register(SecondScreenCell.self, forCellReuseIdentifier: SecondScreenCell.reuseId)
        characterTabaleView.dataSource = self
        characterTabaleView.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
            withIdentifier: SecondScreenCell.reuseId,
            for: indexPath) as? SecondScreenCell
        else {
            return UITableViewCell()
        }
        
        let character = characters[indexPath.row]
        cell.configure(with: character.name, images: characterNames)
        
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

    

