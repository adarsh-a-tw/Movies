//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Adarsh A on 16/09/22.
//

import Foundation

struct MovieViewModel : Identifiable, Equatable {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var id : String { movie.id }
    var title: String { movie.title }
    var description: String { movie.description }
    var logoURL: String { movie.logoURL }
    var rating: Float { movie.rating }
    
    var tileViewModel : MovieTileViewModel {
        MovieTileViewModel(movie: movie)
    }
}
