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

    // MARK: - overide UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        view.backgroundColor = .cyan
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .lightGray
        view.addSubview(collectionView)
        
        collectionView.register(UserActionCell.self, forCellWithReuseIdentifier: UserActionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserActionCell.reuseId, for: indexPath) as? UserActionCell else {
            print("Not")
            return UICollectionViewCell() }
        
        cell.backgroundColor = .black
        cell.labelView.text = "CELL"
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: UIScreen.main.bounds.width - 68, height: 200)
    }
}

