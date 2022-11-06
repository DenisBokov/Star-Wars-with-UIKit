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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
