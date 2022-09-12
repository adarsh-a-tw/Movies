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
    @Published var error: APIServiceError? = nil
    @Published var isError: Bool = false
    @Published var isLoading: Bool = true
    
    init(apiService:APIServiceProtocol = MovieAPIService()) {
        self.apiService = apiService
        loadMovies()
    }
    
    func loadMovies() {
        apiService.getMovies(completionHandler: completionHandler)
    }
    
    func completionHandler(movies: [Movie]?,error: Error?) {
        guard error == nil else {
            DispatchQueue.main.async { [weak self] in
                self?.error = error as? APIServiceError
                self?.isLoading = false
                self?.isError = true
            }
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.movies = movies!
            self?.isLoading = false
            self?.isError = false
            self?.error = nil
        }
    }
    
}
