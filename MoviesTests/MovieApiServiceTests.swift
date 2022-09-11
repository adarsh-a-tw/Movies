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
        let stubbedData = [
            TestConstants.MovieData,
            TestConstants.rawImageData1,
            TestConstants.rawImageData2
        ]
        session = URLSessionStub(data: stubbedData, error: nil)
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
                    XCTAssert(self.session.calledURLs[0] == Constants.MovieAPIUrl)
                    XCTAssert(self.session.calledURLs[1] == TestConstants.moviePosterURLs[0])
                    XCTAssert(self.session.calledURLs[2] == TestConstants.moviePosterURLs[1])
                    promise.fulfill()
                }
        }
                                        
        wait(for: [promise], timeout: 5)
    }
}
