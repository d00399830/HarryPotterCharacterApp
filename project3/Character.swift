//
//  Character.swift
//  project3
//
//  Created by Stratton McDonald on 11/11/21.
//

import Foundation

class Character: Codable {
    let name: String
    let house: String
    let ancestry: String
    let patronus: String
    let species: String
    let image:  String
    let dateOfBirth: String
    let alive: Bool
    let wizard: Bool
    
    enum CodingKeys: String, CodingKey {
            case name
            case house
            case ancestry
            case patronus
            case species
            case image
            case dateOfBirth
            case alive
            case wizard
    }
}
extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        // Two Photos are the same if they have the same photoID
        return lhs.name == rhs.name
    }
}
