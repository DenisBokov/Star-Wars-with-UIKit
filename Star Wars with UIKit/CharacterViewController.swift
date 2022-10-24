//
//  CharacterViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    // MARK: - Private property
    
    private let characterTabaleView = UITableView()
    
    // MARK: - Override UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(characterTabaleView)
        characterTabaleView.showsVerticalScrollIndicator = false
        characterTabaleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterTabaleView.topAnchor.constraint(equalTo: view.topAnchor),
            characterTabaleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTabaleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterTabaleView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        characterTabaleView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        characterTabaleView.dataSource = self
        characterTabaleView.delegate = self
    }
    
}

// MARK: - UITableViewDelegate

extension CharacterViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hallo"
        
        return cell
    }
    
    
}
