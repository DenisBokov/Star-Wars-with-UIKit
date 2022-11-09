//
//  CharacterFilmsViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 09.11.2022.
//

import UIKit

final class CharacterFilmsViewController: UIViewController {
    
    // MARK: - Pablic property
    
    var character: Character!
    var films: [Film] = []
    
    // MARK: - Private property
    
    private let characterFilmsTableView = UITableView()
    private let filmTitles = ImageData.filmTitles
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
        characterFilmsTableView.rowHeight = 100
        
        view.addSubview(characterFilmsTableView)
        view.addSubview(activityIndicator)
        characterFilmsTableView.showsVerticalScrollIndicator = false
        characterFilmsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            characterFilmsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            characterFilmsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterFilmsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterFilmsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        characterFilmsTableView.register(SecondScreenCell.self, forCellReuseIdentifier: SecondScreenCell.reuseId)
        characterFilmsTableView.dataSource = self
        characterFilmsTableView.delegate = self
    }
}

// MARK: - UITableViewDelegate

extension CharacterFilmsViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension CharacterFilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondScreenCell.reuseId, for: indexPath) as? SecondScreenCell else { return UITableViewCell() }
        
        let filmURL = character.films[indexPath.row]
        
        NetworkManager.shared.fetch(Film.self, from: filmURL) { [weak self] result in
            switch result {
            case .success(let film):
                self?.films.append(film)
                cell.configure(with: film.title, images: self?.filmTitles ?? [])
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
}
