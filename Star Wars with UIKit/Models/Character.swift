//
//  Character.swift
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
    
    var description: String {
        """
    Name: \(name)
    BirthYear: \(birthYear)
    Gender: \(gender)
    Height: \(height)
    Mass: \(mass)
    HairColor: \(hairColor)
    """
    }
}

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
}

struct FilmStarWars: Decodable {
    let next: String?
    let previous: String?
    let results: [Film]
}

struct Film: Decodable {
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [String]
    let planets: [String]
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
