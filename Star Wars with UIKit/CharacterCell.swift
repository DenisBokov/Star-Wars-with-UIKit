//
//  CharacterCell.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    static let characterReuseId = "characterCell"
    
    var characterNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 10, weight: .bold)
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(characterNameLabel)
        
        NSLayoutConstraint.activate([
            characterNameLabel.topAnchor.constraint(equalTo: topAnchor),
            characterNameLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
