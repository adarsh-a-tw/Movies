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
    @Published var errorMessage: String? = nil
    @Published var isError: Bool = false
    @Published var isLoading: Bool = true
    
    init(apiService:APIServiceProtocol = MovieAPIService()) {
        self.apiService = apiService
        loadMovies()
    }
    
    func loadMovies() {
        apiService.getMovies(completionHandler: completionHandler)
    }
    
    private func completionHandler(movies: [Movie]?,error: Error?) {
        guard error == nil else {
            let apiServiceError = error as! APIServiceError
            let errorMessage = getErrorMessage(apiServiceError: apiServiceError)
            setError(errorMessage: errorMessage)
            return
        }
        setData(movies: movies!)
    }
    
    private func getErrorMessage(apiServiceError: APIServiceError) -> String{
        switch apiServiceError {
            case .networkError : return Constants.ContentView.Alert.NetworkErrorMessage
            default: return Constants.ContentView.Alert.ServerErrorMessage
        }
    }
    
    private func setError(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = errorMessage
            self?.isLoading = false
            self?.isError = true
        }
    }
        
    private func setData(movies: [Movie]) {
        DispatchQueue.main.async { [weak self] in
            self?.movies = movies
            self?.isLoading = false
            self?.isError = false
            self?.errorMessage = nil
        }
    }
    
}
