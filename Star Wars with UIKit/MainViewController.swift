//
//  MainViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 21.10.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - private property
    
    private var collectionView: UICollectionView!
    private var collectionCellModel = CollectionCellModel.fetchLink()

    // MARK: - overide UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .lightGray
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(UserActionCell.self, forCellWithReuseIdentifier: UserActionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate { }

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

