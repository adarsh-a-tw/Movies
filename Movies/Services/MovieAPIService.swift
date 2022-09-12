//
//  MovieAPIService.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import Foundation

class MovieAPIService: APIServiceProtocol {
    private var session: URLSessionProtocol
    
    init(session:URLSessionProtocol = URLSession(configuration: .default)){
        self.session = session
    }
    
    func getMovies(completionHandler :@escaping ([Movie]? ,Error?) -> Void) {
        let request = URLRequest(url: URL(string:Constants.MovieAPIUrl)!)
        let task = session.dataTask(with: request) { ( data: Data?, response: URLResponse? ,error: Error?) in
            do {
                try completionHandler(self.convertToMovies(data: data!),error)
            }
            catch {
                completionHandler(nil,error)
            }
        }
        task.resume()
    }
    
    private func convertToMovies(data: Data) throws -> [Movie] {
        let response =  try JSONDecoder().decode(APIResponse.self, from: data)
        let cards: [Card] = response.data.cards
        
        return cards.map({
            Movie(id: $0.id,
                  title: $0.content.title,
                  description: $0.content.description,
                  logoURL: $0.content.logoURL,
                  rating: $0.content.rating)
        })
    }
}



