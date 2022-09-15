//
//  Constants.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import Foundation

struct Constants {
    
    static let MovieAPIUrl = ProcessInfo.processInfo.environment["MOVIE_API_URL"]!
    
    struct ContentView {
        
        static let NavigationTitle = "Movies"
        
        struct Alert {
            
            static let Title = "Error"
            static let NetworkErrorMessage = "Check your internet connection."
            static let ServerErrorMessage = "Server sent an invalid response. Try again later."
            static let UnknownErrorMessage = "Unknown Error."
            static let RetryButtonText = "Retry"
        
        }
    }
}
