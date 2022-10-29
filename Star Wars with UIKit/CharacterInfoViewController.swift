//
//  CharacterInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 28.10.2022.
//

import UIKit

final class CharacterInfoViewController: UIViewController {
    
    // MARK: - Private property
    
    private let character: Character! = nil
    
    private var characterInfoImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = character.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(characterInfoImage)
        
        NSLayoutConstraint.activate([
            characterInfoImage.topAnchor.constraint(equalTo: view.topAnchor),
            characterInfoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterInfoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterInfoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
