//
//  FilmInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 31.10.2022.
//

import UIKit

final class FilmInfoViewController: UIViewController {
    
    // MARK: - Public Property
    
    var film: Film!
    private var imagefilms = ImageData.filmTitles
    
    // MARK: - Private property
    
    private lazy var filmInfoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var episodeIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameKyeEpisodeIid: UILabel = {
        let label = UILabel()
        label.text = "Episode: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameKyeDirector: UILabel = {
        let label = UILabel()
        label.text = "Director: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var producerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameKyeProducer: UILabel = {
        let label = UILabel()
        label.text = "Producer: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameKyeReleaseDate: UILabel = {
        let label = UILabel()
        label.text = "Release date: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = film.title
        
        imagefilms.forEach { image in
            if image == film.title {
                filmInfoImage.image = UIImage(named: image)
            }
        }
        
        setupLayout(with: nameKyeEpisodeIid, and: episodeIdLabel, with: 200)
        setupLayout(with: nameKyeDirector, and: directorLabel, with: 240)
        setupLayout(with: nameKyeProducer, and: producerLabel, with: 280)
        setupLayout(with: nameKyeReleaseDate, and: releaseDateLabel, with: 320)
        
        episodeIdLabel.text = String(film.episodeId)
        directorLabel.text = film.director
        producerLabel.text = film.producer
        releaseDateLabel.text = film.releaseDate
    }
    
    // MARK: - Private function
    
    private func setupLayout(with labelOne: UILabel, and labelTwo: UILabel, with constant: CGFloat) {
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
        
        self.view.addSubview(stackview)
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        self.view.addSubview(filmInfoImage)
        NSLayoutConstraint.activate([
            filmInfoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmInfoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filmInfoImage.widthAnchor.constraint(equalToConstant: 350),
            filmInfoImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
