//
//  FilmInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 31.10.2022.
//

import UIKit

final class FilmInfoViewController: UIViewController {
    
    var film: Film!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = film.title
    }
    
}
