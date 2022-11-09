//
//  FilmCharactersViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 10.11.2022.
//

import UIKit

final class FilmCharactersViewController: UIViewController {
    
    // MARK: - Public property
    
    var film: Film!
    var characters: [Character] = []
    
    // MARK: - Private property
    
    private let filmCharactersTableView = UITableView()
    private let characterName = ImageData.characterNames
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
        filmCharactersTableView.rowHeight = 100
        
        view.addSubview(filmCharactersTableView)
        view.addSubview(activityIndicator)
        filmCharactersTableView.showsVerticalScrollIndicator = false
        filmCharactersTableView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            filmCharactersTableView.topAnchor.constraint(equalTo: view.topAnchor),
            filmCharactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filmCharactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmCharactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        filmCharactersTableView.register(SecondScreenCell.self, forCellReuseIdentifier: SecondScreenCell.reuseId)
        filmCharactersTableView.dataSource = self
        filmCharactersTableView.delegate = self
    }
}

// MARK: - UITableViewDelegate

extension FilmCharactersViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension FilmCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        film.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondScreenCell.reuseId, for: indexPath) as? SecondScreenCell else { return UITableViewCell() }
        
        let characterURL = film.characters[indexPath.row]
        
        NetworkManager.shared.fetch(Character.self, from: characterURL) { [weak self] result in
            switch result {
            case .success(let character):
                self?.characters.append(character)
                cell.configure(with: character.name, images: self?.characterName ?? [])
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
}
