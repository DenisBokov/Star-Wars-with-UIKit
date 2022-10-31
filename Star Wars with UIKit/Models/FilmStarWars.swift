//
//  FilmStarWars.swift
//  Star Wars with UIKit
//
//  Created by Denis Bokov on 31.10.2022.
//

import Foundation

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
