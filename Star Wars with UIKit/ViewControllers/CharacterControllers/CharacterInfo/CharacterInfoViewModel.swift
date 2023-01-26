//
//  CharacterInfoViewModel.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 26.01.2023.
//

import Foundation

protocol CharacterInfoViewModelProtocol {
    var homeWorld: String? { get }
    var gender: String { get }
    var height: String { get }
    var mass: String { get }
    var birthYear: String { get }
    
    init(character: Character, planet: Planet)
}

class CharacterInfoViewModel: CharacterInfoViewModelProtocol {
    
    var birthYear: String {
        character.birthYear
    }
    
    var mass: String {
        character.mass
    }
    
    var height: String {
        character.height
    }
    
    var homeWorld: String? {
        planet.name
    }
    
    var gender: String {
        character.gender
    }
    
    private let character: Character
    private let planet: Planet
    
    required init(character: Character, planet: Planet) {
        self.character = character
        self.planet = planet
    }
}
