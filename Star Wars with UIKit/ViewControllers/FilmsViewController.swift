//
//  FilmsViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 31.10.2022.
//

import UIKit

final class FilmsViewController: UIViewController {
    
    // MARK: - Public property
    
    var navigationTitle: String!
    
    // MARK: - Private property
    
    private var films: [Film] = []
    private let filmTabaleView = UITableView()
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
        
        filmTabaleView.rowHeight = 100
        
        view.addSubview(filmTabaleView)
        view.addSubview(activityIndicator)
        filmTabaleView.showsVerticalScrollIndicator = false
        filmTabaleView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            filmTabaleView.topAnchor.constraint(equalTo: view.topAnchor),
            filmTabaleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filmTabaleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmTabaleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        filmTabaleView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.characterReuseId)
        filmTabaleView.dataSource = self
        filmTabaleView.delegate = self
        
        
        fechDataForAllFilms()
      
    }
}

// MARK: - UITableViewDelegate

extension FilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let filmRow = films[indexPath.row]
//        let characterInfoViewController = CharacterInfoViewController()
//        characterInfoViewController.character = filmRow
//        navigationController?.pushViewController(characterInfoViewController, animated: true)
//        characterTabaleView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension FilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
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
            if films[indexPath.row].title == image.rawValue {
                cell.characterImage.image = UIImage(named: image.rawValue)
            }
        }
        
        cell.characterNameLabel.text = films[indexPath.row].title
        
        return cell
    }
}

// MARK: - Networking

extension FilmsViewController {
    private func fechDataForAllFilms() {
        NetworkManager.shared.fetch(FilmStarWars.self, from: Link.filmsLink.rawValue) { [weak self] result in
            switch result {
            case .success(let jsonFilms):
                self?.films = jsonFilms.results
                self?.activityIndicator.stopAnimating()
                self?.filmTabaleView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

