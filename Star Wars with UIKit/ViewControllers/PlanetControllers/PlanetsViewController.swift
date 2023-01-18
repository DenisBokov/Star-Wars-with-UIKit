//
//  PlanetsViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 06.11.2022.
//

import UIKit

final class PlanetsViewController: UIViewController {
    
    // MARK: - Public property
    var navigationTitle: String!
    var planets: [Planet] = []
    
    // MARK: - Private property
    private let planetTableView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
     
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Private mothods
    private func setupTableView() {
        planetTableView.rowHeight = 100
        
        view.addSubview(planetTableView)
        view.addSubview(activityIndicator)
        planetTableView.showsVerticalScrollIndicator = false
        planetTableView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            planetTableView.topAnchor.constraint(equalTo: view.topAnchor),
            planetTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            planetTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            planetTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        planetTableView.register(SecondScreenCell.self, forCellReuseIdentifier: SecondScreenCell.reuseId)
        planetTableView.dataSource = self
        planetTableView.delegate = self
    }
}

// MARK: - UITableViewDelegate
extension PlanetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let planetRow = planets[indexPath.row]
        let planetInfoViewController = PlanetInfoViewController()
        planetInfoViewController.planet = planetRow
        navigationController?.pushViewController(planetInfoViewController, animated: true)
        planetTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PlanetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(
            withIdentifier: SecondScreenCell.reuseId,
            for: indexPath) as? SecondScreenCell
        else {
            return UITableViewCell()
        }

        let planet = planets[indexPath.row].name
//        cell.configure(with: film, images: filmTitles)
        
        return cell
    }
}
