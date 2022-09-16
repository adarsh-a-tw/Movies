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
            loadingView
        }
        else {
            if !$movieViewModel.isError.wrappedValue {
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
            }.navigationTitle(Constants.ContentView.NavigationTitle)
             .background(Color.black).navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/).toolbar {
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
    
    var errorView: some View {
        ZStack{
        }.alert(isPresented: $movieViewModel.isError) {
            Alert(title: Text(Constants.ContentView.Alert.Title), message: Text($movieViewModel.errorMessage.wrappedValue ?? Constants.ContentView.Alert.UnknownErrorMessage), dismissButton: .default(Text(Constants.ContentView.Alert.RetryButtonText)){
                movieViewModel.loadMovies()
            })
        }.background(.black)
    }
    
    var gridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach($movieViewModel.movies.wrappedValue,id: \.self.id,content: {
                    movie in
                    NavigationLink(destination: MovieDetailView(movie: movie).padding(0)) {
                        MovieTileView(movie: movie)
                    }
                })
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
