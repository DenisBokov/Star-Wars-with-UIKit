//
//  CharacterViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class CharacterViewController: UIViewController {
    
    // MARK: - Private property
    
    private var characters: [Character] = []
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
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            do {
                guard let data = data, let response = response else {
                    print(error?.localizedDescription ?? "Not error")
                    return
                }
                print(response)
                
                let jsonCharacter = try JSONDecoder().decode(PeopleStarWars.self, from: data)
                self?.characters = jsonCharacter.results
                
                DispatchQueue.main.async {
                    self?.characterTabaleView.reloadData()
                }
    
            } catch {
                
            }
        }.resume()
    }
    
}

// MARK: - UITableViewDelegate

extension CharacterViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = characters[indexPath.row].name
        
        return cell
    }
    
    
}
