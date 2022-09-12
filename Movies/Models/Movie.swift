//
//  Movie.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import Foundation

struct Movie : Equatable {
    let id: String
    let title: String
    let description: String
    var logoURL: String
    let rating: Float
}
