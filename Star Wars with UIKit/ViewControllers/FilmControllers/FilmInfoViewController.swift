//
//  FilmInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 31.10.2022.
//

import UIKit

final class FilmInfoViewController: BaseInfoViewController {
    
    // MARK: - Public Property
    var film: Film!
    
    // MARK: - Private property
    private var imagefilms = ImageData.filmTitles
    
    private lazy var filmInfoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        imagefilms.forEach { image in
            if image == film.title {
                filmInfoImage.image = UIImage(named: image)
            }
        }
        
        setupImageLayout(forImage: filmInfoImage)
        
        setupLayout(
            forLabelOne: setupKeyLabel(for: "Episode: "),
            andLabelTwo: setupMeaningLabel(for: String(film.episodeId)),
            withConstant: 200
        )
        setupLayout(
            forLabelOne: setupKeyLabel(for: "Director: "),
            andLabelTwo: setupMeaningLabel(for: film.director),
            withConstant: 240
        )
        setupLayout(
            forLabelOne: setupKeyLabel(for: "Producer: "),
            andLabelTwo: setupMeaningLabel(for: film.producer),
            withConstant: 280
        )
        setupLayout(
            forLabelOne: setupKeyLabel(for: "Release date: "),
            andLabelTwo: setupMeaningLabel(for: film.releaseDate),
            withConstant: 320
        )
    }
    
    // MARK: - Private function
    private func setupKeyLabel(for string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    private func setupMeaningLabel(for string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = UIColor.white
        navigationItem.title = film.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Characters",
            image: nil,
            target: self,
            action: #selector(goToCharactersScreen)
        )
    }
    
    @objc private func goToCharactersScreen() {
        let filmCharacterViewController = FilmCharactersViewController()
        filmCharacterViewController.film = film
        present(filmCharacterViewController, animated: true)
    }
    
}
