//
//  CharacterInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 28.10.2022.
//

import UIKit

final class CharacterInfoViewController: BaseInfoViewController {
    
    // MARK: - Public Property
    var character: Character!
    var planet: Planet!
    
    var viewModel: CharacterInfoViewModelProtocol! {
        didSet {
            
        }
    }
    
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
        
        viewModel = CharacterInfoViewModel(character: character, planet: planet)
        
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
            andLabelTwo: setupLabel(for: viewModel.gender),
            withConstant: 240
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Height: "),
            andLabelTwo: setupLabel(for: viewModel.height),
            withConstant: 280
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Mass: "),
            andLabelTwo: setupLabel(for: viewModel.mass),
            withConstant: 320
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Birth Year: "),
            andLabelTwo: setupLabel(for: viewModel.birthYear),
            withConstant: 360
        )
        
        fetchPlanet()
    }
    
    // MARK: - Private methods
    private func setupNavigationBar() {
        view.backgroundColor = UIColor.white
        navigationItem.title = character.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Films",
            image: nil,
            target: self,
            action: #selector(goToFilmsScreen)
        )
    }
    
    @objc private func goToFilmsScreen() {
        let charcterFilmViewController = CharacterFilmsViewController()
        charcterFilmViewController.character = character
        present(charcterFilmViewController, animated: true)
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





