//
//  MovieListViewModelTests.swift
//  MoviesTests
//
//  Created by Adarsh A on 11/09/22.
//

import Foundation

import XCTest

@testable import Movies

class MovieListViewModelTests: XCTestCase {
    
    var sut: MovieListViewModel!
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
        sut = MovieListViewModel(apiService: apiService)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {[weak sut] in
            XCTAssert(sut!.movies == TestConstants.movieViewModels)
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
        sut = MovieListViewModel(apiService: apiService)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {[weak sut] in
            XCTAssertTrue(sut!.isError)
            XCTAssertNil(sut!.movies)
            XCTAssertFalse(sut!.isLoading)
            XCTAssertEqual(sut!.errorMessage, Constants.ContentView.Alert.NetworkErrorMessage)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    func testGetMoviesFailureDueToOtherAPIError() {
        let promise = expectation(description: "Waiting expectation")
        apiService = MockMovieAPIService(movies: [], success: false, error: APIServiceError.badServerResponse(500))
        sut = MovieListViewModel(apiService: apiService)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {[weak sut] in
            XCTAssertTrue(sut!.isError)
            XCTAssertNil(sut!.movies)
            XCTAssertFalse(sut!.isLoading)
            XCTAssertEqual(sut!.errorMessage, Constants.ContentView.Alert.ServerErrorMessage)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 2.0)
    }
}

