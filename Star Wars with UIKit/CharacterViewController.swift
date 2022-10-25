//
//  CharacterViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    // MARK: - Private property
    
    private let character: Character? = nil
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
        
        fechData()
    }
    
    private func fechData() {
        guard let url = URL(string: Link.characterLink.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "Not error")
                return
            }
            
            print(data, response)
        }
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
