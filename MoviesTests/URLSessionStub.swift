//
//  URLSessionStub.swift
//  MoviesTests
//
//  Created by Adarsh A on 09/09/22.
//

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

import Foundation

@testable import Movies

class URLSessionStub: URLSessionProtocol {
  private let stubbedData: Data?
  private var stubbedResponse: URLResponse? = nil
  private var stubbedError: Error? = nil
  private var statusCode: Int = 200
  public var calledURL: String? = nil
 

  public init(data: Data?, error: Error? = nil, statusCode: Int = 200) {
        self.stubbedData = data
        self.stubbedError = error
        self.statusCode = statusCode
  }

  public func dataTask(
    with request: URLRequest,
    completionHandler: @escaping DataTaskCompletionHandler
  ) -> URLSessionDataTask {
      
    stubbedResponse = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    calledURL = request.url!.absoluteString
    return URLSessionDataTaskStub(
      stubbedData: stubbedData,
      stubbedResponse: stubbedResponse,
      stubbedError: stubbedError,
      completionHandler: completionHandler
    )
      
  }
    
}

class URLSessionDataTaskStub: URLSessionDataTask {
  private let stubbedData: Data?
  private let stubbedResponse: URLResponse?
  private let stubbedError: Error?
  private let completionHandler: DataTaskCompletionHandler?

  init(
    stubbedData: Data? = nil,
    stubbedResponse: URLResponse? = nil,
    stubbedError: Error? = nil,
    completionHandler: DataTaskCompletionHandler? = nil
  ) {
    self.stubbedData = stubbedData
    self.stubbedResponse = stubbedResponse
    self.stubbedError = stubbedError
    self.completionHandler = completionHandler
  }

  override func resume() {
    completionHandler?(stubbedData, stubbedResponse, stubbedError)
  }
}
