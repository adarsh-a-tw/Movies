//
//  URLSessionStub.swift
//  MoviesTests
//
//  Created by Adarsh A on 09/09/22.
//

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias DownloadTaskCompletionHandler = (URL?, URLResponse?, Error?) -> Void

import Foundation

@testable import Movies

class URLSessionStub: URLSessionProtocol {
  private let stubbedData: Data?
  private var stubbedResponse: URLResponse? = nil
  private var stubbedError: Error? = nil
  public var calledURL: String? = nil
 

  public init(data: Data?, error: Error? = nil) {
        self.stubbedData = data
        self.stubbedError = error
  }

  public func dataTask(
    with request: URLRequest,
    completionHandler: @escaping DataTaskCompletionHandler
  ) -> URLSessionDataTask {
      
    stubbedResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
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
