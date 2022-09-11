//
//  MovieAPIService.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import Foundation

class MovieAPIService {
    private var session: URLSessionProtocol
    private var movies: [Movie]
    let group = DispatchGroup()
    
    init(session:URLSessionProtocol = URLSession(configuration: .default)){
        self.session = session
        self.movies = []
    }
    
    func getMovies(completionHandler :@escaping ([Movie]? ,Error?) -> Void) {
        let request = URLRequest(url: URL(string:Constants.MovieAPIUrl)!)
        let task = session.dataTask(with: request) { ( data: Data?, response: URLResponse? ,error: Error?) in
            do {
                try self.convertToMovies(data: data!)
                self.group.notify(queue: .global()) {
                    completionHandler(self.movies,error)
                }
            }
            catch {
                completionHandler(nil,error)
            }
        }
        task.resume()
    }
    
    private func convertToMovies(data: Data) throws  {
        let response =  try JSONDecoder().decode(APIResponse.self, from: data)
        let cards: [Card] = response.data.cards
        
        cards.forEach({
            let logoURL = $0.content.logoURL
            let movie = Movie(id: $0.id,
                  title: $0.content.title,
                  description: $0.content.description,
                  logo: nil,
                  rating: $0.content.rating)
            self.movies.append(movie)
            let index = movies.endIndex - 1
            
            self.getMoviePoster(rawURL: logoURL,index:index) {
                (data: Data?, error: Error?) -> Void in
                if let data = data {
                    self.movies[index].logo = data
                }
            }
            
        })
    }
    
    private func getMoviePoster(rawURL: String,index: Int, completionHandler :@escaping (Data? ,Error?) -> Void) {
        let request = URLRequest(url: URL(string:rawURL)!)
        group.enter()
        let task = session.dataTask(with: request) { ( data: Data?, response: URLResponse? ,error: Error?) in
            
            defer{
                self.group.leave()
            }
            
            guard let data = data else {
                completionHandler(nil,error)
                return
            }
            
            completionHandler(data,nil)
        }
        task.resume()
    }
}



