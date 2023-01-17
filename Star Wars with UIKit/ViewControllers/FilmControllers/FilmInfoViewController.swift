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
            forLabelOne: setupLabel(for: "Episode: "),
            andLabelTwo: setupLabel(for: String(film.episodeId)),
            withConstant: 200
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Director: "),
            andLabelTwo: setupLabel(for: film.director),
            withConstant: 240
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Producer: "),
            andLabelTwo: setupLabel(for: film.producer),
            withConstant: 280
        )
        setupLayout(
            forLabelOne: setupLabel(for: "Release date: "),
            andLabelTwo: setupLabel(for: film.releaseDate),
            withConstant: 320
        )
    }
    
    // MARK: - Private function
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
