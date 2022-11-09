//
//  PeopleStarWars.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 24.10.2022.
//

import Foundation

struct PeopleStarWars: Decodable {
    let next: String?
    let previous: String?
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let birthYear: String
    let gender: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor:String
    let homeworld: String
    let films: [String]
    let starships: [String]
}

struct Starchip: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let starshipClass: String
    let films: [Film]
}
