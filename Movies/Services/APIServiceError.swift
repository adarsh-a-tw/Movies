//
//  APIServiceError.swift
//  Movies
//
//  Created by Adarsh A on 12/09/22.
//

import Foundation

enum APIServiceError: Error ,Equatable{
    
    case networkError
    case emptyResponse
    case badServerResponse(Int)
    case decodingError
    
}
