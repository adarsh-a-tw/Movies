//
//  MoviesApp.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject var viewModel = MovieListViewModel()
    var body: some Scene {
        WindowGroup {
            MovieListView().environmentObject(viewModel)
        }
    }
}
