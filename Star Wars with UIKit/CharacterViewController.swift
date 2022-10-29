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
    private let activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.startAnimating()
        return activityView
    }()
    
    // MARK: - Override UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Character"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        characterTabaleView.rowHeight = 100
        
        view.addSubview(characterTabaleView)
        view.addSubview(activityIndicator)
        characterTabaleView.showsVerticalScrollIndicator = false
        characterTabaleView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.center = view.center
        
        NSLayoutConstraint.activate([
            characterTabaleView.topAnchor.constraint(equalTo: view.topAnchor),
            characterTabaleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTabaleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterTabaleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        characterTabaleView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.characterReuseId)
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
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonCharacter = try decoder.decode(PeopleStarWars.self, from: data)
                self?.characters = jsonCharacter.results
                
                DispatchQueue.main.async {
                    self?.characterTabaleView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
    
            } catch {
                
            }
        }.resume()
    }
    
}

// MARK: - UITableViewDelegate

extension CharacterViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let character = characters[indexPath.row]
//
//        
//    }
}

// MARK: - UITableViewDataSource

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.characterReuseId,
            for: indexPath) as? CharacterCell
        else {
            return UITableViewCell()
            
        }
        
        cell.characterImage.image = UIImage(named: "people")
        cell.characterNameLabel.text = characters[indexPath.row].name
        
        return cell
    }
    
    
}
    
    

