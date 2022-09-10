//
//  MovieViewModel.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import Foundation

class MovieViewModel : ObservableObject {
    private var apiService: MovieAPIService
    @Published private(set) var movies: [Movie] = []
    
    init(apiService:MovieAPIService) {
        self.apiService = apiService
    }
}
