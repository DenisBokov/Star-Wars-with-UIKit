//
//  MainViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 21.10.2022.
//

import UIKit

enum Link: String, CaseIterable {
    case characterLink = "https://swapi.dev/api/people/"
    case filmsLink = "https://swapi.dev/api/films/"
    case planetsLink = "https://swapi.dev/api/planets/"
    case starchipsLink = "https://swapi.dev/api/starships/"
}

final class MainViewController: UIViewController {
    
    // MARK: - private property
    private var collectionView: UICollectionView!
    private var collectionCellModel = DataModelForFistScreen.fetchLink()
    private let userActions = Link.allCases

    // MARK: - overide UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    // MARK: - Private function
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(UserActionCell.self, forCellWithReuseIdentifier: UserActionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = collectionCellModel[indexPath.item]
        
        if userAction.collectionLabel == "Characters" {
            let characterViewController = CharacterViewController()
            navigationController?.pushViewController(characterViewController, animated: true)
            characterViewController.navigationTitle = "Characters"
        } else if userAction.collectionLabel == "Films" {
            let filmViewController = FilmsViewController()
            navigationController?.pushViewController(filmViewController, animated: true)
            filmViewController.navigationTitle = "Films"
        } else if userAction.collectionLabel == "Planets" {
            let planetViewController = PlanetsViewController()
            navigationController?.pushViewController(planetViewController, animated: true)
            planetViewController.navigationTitle = "Planets"
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionCellModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UserActionCell.reuseId,
            for: indexPath) as? UserActionCell
        else {
            return UICollectionViewCell()
            
        }
        
        cell.imageView.image = UIImage(named: collectionCellModel[indexPath.item].mainImage)
        cell.labelView.text = collectionCellModel[indexPath.item].collectionLabel
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: UIScreen.main.bounds.width - 68, height: 200)
    }
}


