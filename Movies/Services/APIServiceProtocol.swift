//
//  APIServiceProtocol.swift
//  Movies
//
//  Created by Adarsh A on 11/09/22.
//

import Foundation

protocol APIServiceProtocol {
    func getMovies(completionHandler :@escaping ([Movie]? ,APIServiceError?) -> Void)
}
