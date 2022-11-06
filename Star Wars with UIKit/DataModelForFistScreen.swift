//
//  CollectionCellModel.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 21.10.2022.
//

import UIKit

struct DataModelForFistScreen {
    
    var mainImage: String
    var collectionLabel: String
    
    static func fetchLink() -> [DataModelForFistScreen] {
        let peopleItem = DataModelForFistScreen(
            mainImage: "people",
            collectionLabel: "Characters"
        )
        
        let filmItem = DataModelForFistScreen(
            mainImage: "films",
            collectionLabel: "Films"
        )
        
        let planetItem = DataModelForFistScreen(
            mainImage: "planets",
            collectionLabel: "Planets"
        )
        
        let starshipItem = DataModelForFistScreen(
            mainImage: "starships",
            collectionLabel: "Starchips"
        )
        
        return [peopleItem, filmItem, planetItem, starshipItem]
    }
}
