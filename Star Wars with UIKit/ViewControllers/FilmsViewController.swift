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
    private let filmTitles = ImageData.filmTitles
    
    // MARK: - Override UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
                
        setupTableView()
        fechDataForAllFilms()
      
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
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
        
        filmTabaleView.register(SecondScreenCell.self, forCellReuseIdentifier: SecondScreenCell.reuseId)
        filmTabaleView.dataSource = self
        filmTabaleView.delegate = self
    }
    
//    private func addSubviews(withSubview: UIView...) -> UIView {
//
//    }
}

// MARK: - UITableViewDelegate

extension FilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmRow = films[indexPath.row]
        let filmInfoViewController = FilmInfoViewController()
        filmInfoViewController.film = filmRow
        navigationController?.pushViewController(filmInfoViewController, animated: true)
        filmTabaleView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension FilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(
            withIdentifier: SecondScreenCell.reuseId,
            for: indexPath) as? SecondScreenCell
        else {
            return UITableViewCell()
            
        }

        let film = films[indexPath.row].title
        cell.configure(with: film, images: filmTitles)
        
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

