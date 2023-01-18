//
//  BaseInfoViewController.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 08.11.2022.
//

import UIKit

class BaseInfoViewController: UIViewController {
    
    private let widthConstraint = CGFloat(110)
    private let heightConatraint = CGFloat(100)
    
    func setupLayout(forLabelOne labelOne: UILabel, andLabelTwo labelTwo: UILabel, withConstant constant: CGFloat) {

        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false

        setupSubviews(labelOne, labelTwo, stackview)

        stackview.addArrangedSubview(labelOne)
        NSLayoutConstraint.activate([
            labelOne.widthAnchor.constraint(equalToConstant: widthConstraint),
            labelOne.heightAnchor.constraint(equalToConstant: heightConatraint)
        ])

        stackview.addArrangedSubview(labelTwo)
        NSLayoutConstraint.activate([
            labelTwo.widthAnchor.constraint(equalToConstant: widthConstraint),
            labelTwo.heightAnchor.constraint(equalToConstant: heightConatraint)
        ])

        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func setupImageLayout(forImage image: UIImageView) {
        setupSubviews(image)

        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.widthAnchor.constraint(equalToConstant: 350),
            image.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func setupLabel(for string: String) -> UILabel {
        let label = UILabel()
        label.text = string
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }

    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
}
