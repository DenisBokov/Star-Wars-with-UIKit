//
//  PlanetStarWars.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 10.11.2022.
//

import Foundation

struct PlanetStarWars {
    let next: String?
    let previous: String?
    let results: [Planet]
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
