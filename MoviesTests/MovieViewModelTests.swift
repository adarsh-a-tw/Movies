//
//  MovieViewModelTests.swift
//  MoviesTests
//
//  Created by Adarsh A on 11/09/22.
//

import Foundation

import XCTest

@testable import Movies

class MovieViewModelTests: XCTestCase {
    
    var sut: MovieViewModel!
    var apiService: MockMovieAPIService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        apiService = MockMovieAPIService(movies: TestConstants.movies, success: true, error: nil)
    }

    override func tearDownWithError() throws {
        apiService = nil
        sut = nil
    }

    func testViewModelCreation() {
        sut = MovieViewModel(apiService: apiService)
        XCTAssert(sut.movies == TestConstants.movies)
    }
}

