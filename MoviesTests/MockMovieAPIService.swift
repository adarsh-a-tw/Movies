//
//  MockMovieAPIService.swift
//  MoviesTests
//
//  Created by Adarsh A on 11/09/22.
//

@testable import Movies

class MockMovieAPIService: APIServiceProtocol {
    private let movies: [Movie]
    private let success: Bool
    private let error: APIServiceError?
    
    init(movies: [Movie],success: Bool = true, error: APIServiceError? = nil){
        self.movies = movies
        self.success = success
        self.error = error
    }
    
    func getMovies(completionHandler: @escaping ([Movie]?, APIServiceError?) -> Void) {
        if(success){
            completionHandler(movies,nil)
        }
        else {
            completionHandler(nil, error)
        }
    }
}
