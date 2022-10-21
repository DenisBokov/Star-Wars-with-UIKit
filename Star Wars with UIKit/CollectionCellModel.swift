//
//  CollectionCellModel.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 21.10.2022.
//

import UIKit

struct CollectionCellModel {
    
    var mainImage: String
    var collectionLabel: String
    
    static func fetchLink() -> [CollectionCellModel] {
        let peopleItem = CollectionCellModel(
            mainImage: "people",
            collectionLabel: "Characters"
        )
        
        let filmItem = CollectionCellModel(
            mainImage: "films",
            collectionLabel: "Films"
        )
        
        let planetItem = CollectionCellModel(
            mainImage: "planets",
            collectionLabel: "Planets"
        )
        
        let starshipItem = CollectionCellModel(
            mainImage: "starships",
            collectionLabel: "Starchips"
        )
        
        return [peopleItem, filmItem, planetItem, starshipItem]
    }
}
