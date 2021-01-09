//
//  Person.swift
//  NetworkStackExamples
//
//  Created by Gene Crucean on 1/8/21.
//

import Foundation

// MARK: - People
struct PersonResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Person]
}

// MARK: - Result
struct Person: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

