//
//  CharacterInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 28.10.2022.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    
    // MARK: - Public Property
    
    var films: [Film] = []
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
    
    private lazy var filmsButtom: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.buttonSize = .mini
        buttonConfiguration.title = "Film"
        
        return UIButton(configuration: buttonConfiguration, primaryAction: UIAction { [unowned self] _ in
            dismiss(animated: true)
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        imageCharacter.forEach { image in
            if image == character.name {
                characterInfoImage.image = UIImage(named: image)
            }
        }
        
        setupImageLayout(forImage: characterInfoImage)
        
        setupLayout(
            forLabelOne: setupLabel(for: "Home world: "),
            andLabelTwo: homeWorldLabel,
            withConstant: 200
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Gender: "),
            andLabelTwo: setupLabel(for: character.gender),
            withConstant: 240
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Height: "),
            andLabelTwo: setupLabel(for: character.height),
            withConstant: 280
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Mass: "),
            andLabelTwo: setupLabel(for: character.mass),
            withConstant: 320
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Birth Year: "),
            andLabelTwo: setupLabel(for: character.birthYear),
            withConstant: 360
        )
        
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
    
    
    private func setupLayout(forLabelOne labelOne: UILabel, andLabelTwo labelTwo: UILabel, withConstant constant: CGFloat) {

        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false

        setupSubviews(labelOne, labelTwo, stackview)

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

        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupImageLayout(forImage image: UIImageView) {
        setupSubviews(image)

        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.widthAnchor.constraint(equalToConstant: 350),
            image.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = UIColor.white
        navigationItem.title = character.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Films",
            image: nil,
            target: self,
            action: nil
        )
    }
        
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
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





