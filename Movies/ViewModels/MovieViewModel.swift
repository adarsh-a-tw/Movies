//
//  MovieViewModel.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import Foundation

class MovieViewModel : ObservableObject {
    private var apiService: APIServiceProtocol
    @Published var movies: [Movie] = []
    @Published var error: Error? = nil
    
    init(apiService:APIServiceProtocol = MovieAPIService()) {
        self.apiService = apiService
        apiService.getMovies { movies, error in
            guard error == nil else {
                self.error = error
                return
            }
            self.movies = movies!
        }
    }
    
}
