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
    let images = Image.allCases
    
    // MARK: - Private property
    
    private lazy var filmInfoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var openingCrawlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var nameKyeOpeningCrawl: UILabel = {
        let label = UILabel()
        label.text = "Opening Crawl: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = film.title
        
        images.forEach { image in
            if image.rawValue == film.title {
                filmInfoImage.image = UIImage(named: image.rawValue)
            }
        }
        
        setupLayout(with: nameKyeOpeningCrawl, and: openingCrawlLabel)
        openingCrawlLabel.text = film.openingCrawl
    }
    
    // MARK: - Private function
    
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
//        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant ?? 20).isActive = true
//        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        self.view.addSubview(filmInfoImage)
        filmInfoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filmInfoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        filmInfoImage.widthAnchor.constraint(equalToConstant: 350).isActive = true
        filmInfoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
}
