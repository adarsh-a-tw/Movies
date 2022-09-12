//
//  MovieApiServiceTests.swift
//  MoviesTests
//
//  Created by Adarsh A on 09/09/22.
//

import XCTest

@testable import Movies

class MovieApiServiceTests: XCTestCase {
    
    var sut: MovieAPIService!
    var session: URLSessionStub!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetMoviesSuccessfulResponse() {
        let promise = expectation(description: "Handler invoked")
        session = URLSessionStub(data: TestConstants.MovieData, error: nil)
        sut = MovieAPIService(session:session)
        
        sut.getMovies {
            (data:[Movie]?, error:Error?) -> Void in
                if let data = data {
                    print(TestConstants.movies)
                    XCTAssert(data == TestConstants.movies)
                    XCTAssert(self.session.calledURL == Constants.MovieAPIUrl)
                    promise.fulfill()
                }
        }
                                        
        wait(for: [promise], timeout: 5)
    }
    
    func testGetMoviesFailureOnNoInternetConnectivity() {
        let promise = expectation(description: "Handler invoked")
        session = URLSessionStub(data: nil, error: APIServiceError.networkError)
        sut = MovieAPIService(session:session)
        
        sut.getMovies {
            (data:[Movie]?, error:Error?) -> Void in
            if let error = error as? APIServiceError {
                switch error {
                    case .networkError: promise.fulfill()
                    default: XCTFail()
                }
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testGetMoviesFailureOnEmptyResponse() {
        let promise = expectation(description: "Handler invoked")
        session = URLSessionStub(data: nil, error: nil)
        sut = MovieAPIService(session:session)
        
        sut.getMovies {
            (data:[Movie]?, error:Error?) -> Void in
            if let error = error as? APIServiceError {
                switch error {
                    case .emptyResponse: promise.fulfill()
                    default: XCTFail()
                }
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testGetMoviesFailureOnBadServerResponse() {
        let promise = expectation(description: "Handler invoked")
        session = URLSessionStub(data: nil, error: nil, statusCode: 400)
        sut = MovieAPIService(session:session)
        
        sut.getMovies {
            (data:[Movie]?, error:Error?) -> Void in
            if let error = error as? APIServiceError {
                switch error {
                    case .badServerResponse(let statusCode):
                        if statusCode == 400 {
                            promise.fulfill()
                        }
                    default: XCTFail()
                }
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testGetMoviesFailureOnDecodingJSONResponse() {
        let promise = expectation(description: "Handler invoked")
        session = URLSessionStub(data: "{}".data(using: .utf8), error: nil)
        sut = MovieAPIService(session:session)
        
        sut.getMovies {
            (data:[Movie]?, error:Error?) -> Void in
            if let error = error as? APIServiceError {
                switch error {
                    case .decodingError: promise.fulfill()
                    default: XCTFail()
                }
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
}
