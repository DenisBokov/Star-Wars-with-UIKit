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
    
    // MARK: - Private property
    
    private let planetTableView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
