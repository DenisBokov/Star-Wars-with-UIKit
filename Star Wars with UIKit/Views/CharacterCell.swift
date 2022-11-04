//
//  CharacterCell.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    static let characterReuseId = "characterCell"
    
   var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var characterNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.adjustsFontSizeToFitWidth = true
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(characterImage)
        addSubview(characterNameLabel)
        
        NSLayoutConstraint.activate([
            characterImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            characterImage.heightAnchor.constraint(equalToConstant: 80),
            characterImage.widthAnchor.constraint(equalTo: characterImage.heightAnchor, multiplier: 16/9),
            
            characterNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 20),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 80),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: Character) {
        characterNameLabel.text = character.name
        
        ImageStarWars.allCases.forEach { image in
            if character.name == image.rawValue {
                characterImage.image = UIImage(named: image.rawValue)
            }
        }
    }
}
