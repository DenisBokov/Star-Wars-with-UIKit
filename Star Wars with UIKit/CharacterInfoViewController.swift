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
    
    private lazy var characterInfoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var nameKye: UILabel = {
        let label = UILabel()
        label.text = "Home world: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var nameGenderKye: UILabel = {
        let label = UILabel()
        label.text = "Gender: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var nameHeightKye: UILabel = {
        let label = UILabel()
        label.text = "Height: "
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
        
        setupLayout(with: nameKye, and: planetLabel)
        setupLayout(with: nameGenderKye, and: genderLabel, with: 20)
        setupLayout(with: nameHeightKye, and: heightLabel, with: 40)
        
        genderLabel.text = character.gender
        heightLabel.text = character.height
        
        fetchPlanet()
    }
    
    private func setupLayout(with labelOne: UILabel, and labelTwo: UILabel, with constant: CGFloat? = 0) {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(labelOne)
        labelOne.widthAnchor.constraint(equalToConstant: 100).isActive = true
        labelOne.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackview.addArrangedSubview(labelTwo)
        labelTwo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        labelTwo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.view.addSubview(stackview)
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant ?? 20).isActive = true
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view.addSubview(characterInfoImage)
        characterInfoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        characterInfoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        characterInfoImage.widthAnchor.constraint(equalToConstant: 350).isActive = true
        characterInfoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

// MARK: - Networking

extension CharacterInfoViewController {
    private func fetchPlanet() {
        NetworkManager.shared.fetch(Planet.self, from: character.homeworld) { [weak self] result in
            switch result {
            case .success(let jsonPlanet):
                self?.planetLabel.text = jsonPlanet.name
            case .failure(let error):
                print(error)
            }
        }
    }
}
