//
//  URLSessionProtocol.swift
//  Movies
//
//  Created by Adarsh A on 10/09/22.
//

import Foundation

protocol URLSessionProtocol {
  func dataTask(
    with request: URLRequest,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
  ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
