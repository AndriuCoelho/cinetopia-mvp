//
//  MovieManager.swift
//  Cinetopia
//
//  Created by Andriu Felipe Coelho on 16/11/23.
//

import Foundation

class MovieManager {
    
    // MARK: - Attributes
    
    static let shared = MovieManager()
    var favoritesMovies: [Movie] = []
    
    // MARK: - Init
    
    private init() {
        // Inicialização privada para garantir que apenas uma instância seja criada
    }
    
    // MARK: - Class methods
    
    func add(_ movie: Movie) {
        if favoritesMovies.contains(where: { $0.id == movie.id }) {
            remove(movie)
        } else {
            print("ADICIONANDO: \(movie.title)")
            favoritesMovies.append(movie)
        }
    }
    
    func remove(_ movie: Movie) {
        if let index = favoritesMovies.firstIndex(where: { $0.id == movie.id }) {
            favoritesMovies.remove(at: index)
        }
    }
}
