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
    
    func getMovies(completionHandler :@escaping ([Movie]? ,APIServiceError?) -> Void) {
        let request = URLRequest(url: URL(string:Constants.MovieAPIUrl)!)
        let task = session.dataTask(with: request) { ( data: Data?, response: URLResponse? ,error: Error?) in
            if error != nil {
                completionHandler(nil,APIServiceError.networkError)
                return
            }
            
            guard let response = response else {
                completionHandler(nil,APIServiceError.emptyResponse)
                return
            }


            if let response = response as? HTTPURLResponse {
                if !((200...299).contains(response.statusCode)) {
                    completionHandler(nil,APIServiceError.badServerResponse(response.statusCode))
                    return
                }
            }
            
            guard let data = data else {
                completionHandler(nil,APIServiceError.emptyResponse)
                return
            }

            do {
                try completionHandler(self.convertToMovies(data: data),nil)
            }
            catch {
                completionHandler(nil,APIServiceError.decodingError)
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



