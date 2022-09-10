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
        let data = TestConstants.MovieData.data(using: .utf8)
        session = URLSessionStub(data: data, error: nil)
        sut = MovieAPIService(session:session)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetMovies() {
        let promise = expectation(description: "Handler invoked")
        
        sut.getMovies {
            (data:[Movie]?, error:Error?) -> Void in
                if let data = data {
                    XCTAssert(data == TestConstants.movies)
                    promise.fulfill()
                }
        }
        
        XCTAssert(session.calledURL == Constants.MovieAPIUrl)
        wait(for: [promise], timeout: 5)
    }
}
