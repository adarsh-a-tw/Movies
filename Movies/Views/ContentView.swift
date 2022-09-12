//
//  ContentView.swift
//  Movies
//
//  Created by Adarsh A on 09/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    var body: some View {
        if $movieViewModel.isLoading.wrappedValue {
            ZStack {
                ProgressView().foregroundColor(.orange)
            }.background(.black)
        }
        else {
            if !$movieViewModel.isError.wrappedValue {
                NavigationView {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                                ForEach($movieViewModel.movies.wrappedValue,id: \.self.id,content: {
                                    movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie).padding(0)) {
                                        MovieTileView(movie: movie)
                                    }
                                })
                        }
                    }.navigationTitle(Constants.ContentView.NavigationTitle).background(Color.black).navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/).toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack{
                                Text(Constants.ContentView.NavigationTitle)
                                    .font(.headline)
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
            }
            else {
                ZStack{
                }.alert(isPresented: $movieViewModel.isError) {
                    var errorMessage = Constants.ContentView.Alert.DefaultMessage
                    switch $movieViewModel.error.wrappedValue {
                    case .networkError : errorMessage = Constants.ContentView.Alert.NetworkErrorMessage
                    default: errorMessage = Constants.ContentView.Alert.ServerErrorMessage
                    }
                    
                    return Alert(title: Text(Constants.ContentView.Alert.Title), message: Text(errorMessage), dismissButton: .default(Text(Constants.ContentView.Alert.RetryButtonText)){
                        movieViewModel.loadMovies()
                    })
                }.background(.black)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let movieViewModel = MovieViewModel()
        Group {
            ContentView().previewDevice("iPhone 13").environmentObject(movieViewModel).previewInterfaceOrientation(.portrait)
        }
    }
}
