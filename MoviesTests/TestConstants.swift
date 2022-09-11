//
//  TestConstants.swift
//  MoviesTests
//
//  Created by Adarsh A on 09/09/22.
//

import Foundation

@testable import Movies

struct TestConstants {
    static let MovieData = """
    {
      "data": {
        "cards": [
          {
            "card_id": "movie_1",
            "content": {
              "title": "El Camino' Cooks Up 'Breaking Bad' Easter Eggs",
              "description": "On this spoiler-filled IMDbrief, we break bad and break down the Breaking Bad finale part two: 'El Camino' (2019).",
              "movie_logo": "https://movie-url.test/1",
              "rating": 8
            }
          },
          {
            "card_id": "movie_2",
            "content": {
              "title": "Hello, Dolly!",
              "description": "Matchmaker Dolly Levi travels to Yonkers to find a partner for half-a-millionaire Horace Vandergelder, convincing his niece, his niece's intended, and his two clerks to travel to New York City along the way.",
              "movie_logo": "https://movie-url.test/2",
              "rating": 7.1
            }
          }
        ]
      }
    }
    """.data(using: .utf8)!

    static let movies = [
        Movie(id: "movie_1",
              title: "El Camino' Cooks Up 'Breaking Bad' Easter Eggs",
              description: "On this spoiler-filled IMDbrief, we break bad and break down the Breaking Bad finale part two: 'El Camino' (2019).",
              logo: rawImageData1,
              rating: 8.0),

        Movie(id: "movie_2",
              title: "Hello, Dolly!",
              description: "Matchmaker Dolly Levi travels to Yonkers to find a partner for half-a-millionaire Horace Vandergelder, convincing his niece, his niece's intended, and his two clerks to travel to New York City along the way.",
              logo: rawImageData2,
              rating: 7.1)
    ]

    static let moviePosterURLs = ["https://movie-url.test/1", "https://movie-url.test/2"]
    static let rawImageData1 = "raw_image_data_1".data(using: .utf8)!
    static let rawImageData2 = "raw_image_data_2".data(using: .utf8)!
}
