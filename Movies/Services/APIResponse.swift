//
//  ApiResponse.swift
//  Movies
//
//  Created by Adarsh A on 10/09/22.
//

import Foundation

struct APIResponse: Codable {
    var data: Cards
}

struct Cards: Codable {
    var cards: [Card]
}

struct Card: Codable {
    var id: String
    var content: CardContent
    
    enum CodingKeys: String, CodingKey {
        case id = "card_id", content
    }
}

struct CardContent: Codable {
    var title: String
    var description: String
    var logoURL: String
    var rating: Float
    
    enum CodingKeys: String, CodingKey {
        case title, description, logoURL = "movie_logo", rating
    }
}
