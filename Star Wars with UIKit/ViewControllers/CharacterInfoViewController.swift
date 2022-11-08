//
//  CharacterInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 28.10.2022.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    
    // MARK: - Public Property
    
    var character: Character!
    
    // MARK: - Private property
    
    private let imageCharacter = ImageData.characterNames
    
    private lazy var characterInfoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var homeWorldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = character.name
        
        imageCharacter.forEach { image in
            if image == character.name {
                characterInfoImage.image = UIImage(named: image)
            }
        }
        
        setupLayout(with: setupLabel(for: "Home world: "), and: homeWorldLabel, withConstant: 200)
        setupLayout(with: setupLabel(for: "Gender: "), and: setupLabel(for: character.gender), withConstant: 240)
        setupLayout(with: setupLabel(for: "Height: "), and: setupLabel(for: character.height), withConstant: 280)
        
        fetchPlanet()
    }
    
    // MARK: - Private methods
    
    private func setupLabel(for string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    
    private func setupLayout(with labelOne: UILabel, and labelTwo: UILabel, withConstant constant: CGFloat) {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        stackview.addArrangedSubview(labelOne)
        NSLayoutConstraint.activate([
            labelOne.widthAnchor.constraint(equalToConstant: 110),
            labelOne.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        stackview.addArrangedSubview(labelTwo)
        NSLayoutConstraint.activate([
            labelTwo.widthAnchor.constraint(equalToConstant: 110),
            labelTwo.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(stackview)
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ])
        
        view.addSubview(characterInfoImage)
        NSLayoutConstraint.activate([
            characterInfoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterInfoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterInfoImage.widthAnchor.constraint(equalToConstant: 350),
            characterInfoImage.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

// MARK: - Networking

extension CharacterInfoViewController {
    private func fetchPlanet() {
        NetworkManager.shared.fetch(Planet.self, from: character.homeworld) { [weak self] result in
            switch result {
            case .success(let jsonPlanet):
                self?.homeWorldLabel.text = jsonPlanet.name
            case .failure(let error):
                print(error)
            }
        }
    }
}


