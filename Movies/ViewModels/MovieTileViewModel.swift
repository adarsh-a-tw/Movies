//
//  MovieTileViewModel.swift
//  Movies
//
//  Created by Adarsh A on 16/09/22.
//

import Foundation


struct MovieTileViewModel {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var logoURL: String { movie.logoURL }
    
    let notFoundImageName = "photo.fill"
    let notFoundMessage = "Preview not available"
        
}
