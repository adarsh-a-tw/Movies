//
//  MovieListView.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import SwiftUI

struct MovieListView: View {
    
    @EnvironmentObject var viewModel: MovieListViewModel
    
    var body: some View {
        if viewModel.isLoading {
            loadingView
        }
        else {
            if !viewModel.isError {
                    navigationView
            }
            else {
                errorView
            }
        }
    }
    
    
    var loadingView: some View {
        ZStack {
            ProgressView().tint(.orange)
        }.background(.black)
    }
    
    var navigationView: some View {
        NavigationView {
            ScrollView {
                gridView
            }
            .navigationTitle(Constants.ContentView.NavigationTitle)
            .background(Color.black)
            .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/)
            .toolbar {
                 ToolbarItem(placement: .principal) {
                     VStack{
                         Text(Constants.ContentView.NavigationTitle)
                             .font(.headline)
                             .foregroundColor(.orange)
                     }
                 }
            }
        }
        .accentColor(.orange)
    }
    
    var errorView: some View {
        ZStack{
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(Constants.ContentView.Alert.Title), message: Text($viewModel.errorMessage.wrappedValue ?? Constants.ContentView.Alert.UnknownErrorMessage), dismissButton: .default(Text(Constants.ContentView.Alert.RetryButtonText)){
                viewModel.loadMovies()
            })
        }
        .background(.black)
    }
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(viewModel.movies ?? []){
                movie in
                NavigationLink(destination: MovieView(viewModel: movie).padding(0)) {
                    MovieTileView(viewModel: movie.tileViewModel)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MovieListViewModel()
        Group {
            MovieListView()
                .previewDevice("iPhone 13")
                .environmentObject(viewModel)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
