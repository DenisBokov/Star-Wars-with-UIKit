//
//  CharacterInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 28.10.2022.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    
    // MARK: - Property
    
    var character: Character!
    let images = Image.allCases
    
    // MARK: - Private property
    
    private var characterInfoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "people")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private var planetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = character.name
        
        images.forEach { image in
            if image.rawValue == character.name {
                characterInfoImage.image = UIImage(named: image.rawValue)
            }
        }
        
        view.addSubview(characterInfoImage)
        view.addSubview(planetLabel)
        
        NSLayoutConstraint.activate([
            characterInfoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterInfoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterInfoImage.widthAnchor.constraint(equalToConstant: 350),
            characterInfoImage.heightAnchor.constraint(equalToConstant: 200),
            
            planetLabel.topAnchor.constraint(equalTo: characterInfoImage.bottomAnchor, constant: 20),
            planetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        fetchPlanet()
    }
    
    private func fetchPlanet() {
        guard let url = URL(string: character.homeworld) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            do {
                guard let data = data else {
                    print(error?.localizedDescription ?? "Not error")
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonPlanet = try decoder.decode(Planet.self, from: data)
                
                DispatchQueue.main.async {
                    self?.planetLabel.text = jsonPlanet.name
                }
                
            } catch {
        
            }
        }.resume()
    }
}
