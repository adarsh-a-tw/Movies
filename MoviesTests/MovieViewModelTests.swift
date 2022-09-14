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
    }

    override func tearDownWithError() throws {
        apiService = nil
        sut = nil
    }

    func testGetMoviesSuccess() {
        let promise = expectation(description: "Waiting expectation")
        apiService = MockMovieAPIService(movies: TestConstants.movies, success: true, error: nil)
        sut = MovieViewModel(apiService: apiService)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {[weak sut] in
            XCTAssert(sut!.movies == TestConstants.movies)
            XCTAssertFalse(sut!.isLoading)
            XCTAssertFalse(sut!.isError)
            XCTAssertNil(sut!.errorMessage)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    func testGetMoviesFailureDueToNetworkError() {
        let promise = expectation(description: "Waiting expectation")
        apiService = MockMovieAPIService(movies: [], success: false, error: APIServiceError.networkError)
        sut = MovieViewModel(apiService: apiService)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {[weak sut] in
            XCTAssertTrue(sut!.isError)
            XCTAssert(sut!.movies.count == 0)
            XCTAssertFalse(sut!.isLoading)
            XCTAssertEqual(sut!.errorMessage, Constants.ContentView.Alert.NetworkErrorMessage)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    func testGetMoviesFailureDueToOtherAPIError() {
        let promise = expectation(description: "Waiting expectation")
        apiService = MockMovieAPIService(movies: [], success: false, error: APIServiceError.badServerResponse(500))
        sut = MovieViewModel(apiService: apiService)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {[weak sut] in
            XCTAssertTrue(sut!.isError)
            XCTAssert(sut!.movies.count == 0)
            XCTAssertFalse(sut!.isLoading)
            XCTAssertEqual(sut!.errorMessage, Constants.ContentView.Alert.ServerErrorMessage)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2.0)
    }
}

