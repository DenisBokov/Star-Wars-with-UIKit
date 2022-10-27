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
    let birth_year: String
    let gender: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color:String
    let homeworld: String
    let films: [String]
    let starships: [String]
}

struct Planet: Decodable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let residents: [Character]
    let films: [Film]
}

struct Film: Decodable {
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let producer: String
    let release_date: String
    let characters: [Character]
    let planets: [Planet]
    let starships: [Starchip]
}

struct Starchip: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let cost_in_credits: String
    let length: String
    let max_atmosphering_speed: String
    let crew: String
    let passengers: String
    let starship_class: String
    let films: [Film]
}
