//
//  CharacterCell.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class SecondScreenCell: UITableViewCell {
    
    static let reuseId = "secondScreenCell"
    
   var imageSecondScreen: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var secondScreenNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.adjustsFontSizeToFitWidth = true
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imageSecondScreen)
        addSubview(secondScreenNameLabel)
        
        NSLayoutConstraint.activate([
            imageSecondScreen.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageSecondScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageSecondScreen.heightAnchor.constraint(equalToConstant: 80),
            imageSecondScreen.widthAnchor.constraint(equalTo: imageSecondScreen.heightAnchor, multiplier: 16/9),
            
            secondScreenNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondScreenNameLabel.leadingAnchor.constraint(equalTo: imageSecondScreen.trailingAnchor, constant: 20),
            secondScreenNameLabel.heightAnchor.constraint(equalToConstant: 80),
            secondScreenNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: String, images: [String]) {
        secondScreenNameLabel.text = character
        images.forEach { image in
            if character == image {
                imageSecondScreen.image = UIImage(named: image)
            }
        }
    }
}
