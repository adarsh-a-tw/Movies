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
        session = URLSessionStub(data: TestConstants.MovieData, error: nil)
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
                    print(data)
                    print(TestConstants.movies)
                    XCTAssert(data == TestConstants.movies)
                    XCTAssert(self.session.calledURL == Constants.MovieAPIUrl)
                    promise.fulfill()
                }
        }
                                        
        wait(for: [promise], timeout: 5)
    }
}
