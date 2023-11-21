//
//  Movie.swift
//  Cinetopia
//
//  Created by Giovanna Moeller on 31/10/23.
//

import Foundation

class Movie: Decodable {
    let id: Int
    let title: String
    let image: String
    let synopsis: String
    let rate: Double
    let releaseDate: String
    private(set) var isSelected: Bool? = false
    
    // MARK: - Class methods
    
    func changeSelectionStatus() {
        isSelected = !(isSelected ?? false)
    }
}
