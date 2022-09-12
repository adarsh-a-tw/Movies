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
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach($movieViewModel.movies.wrappedValue,id: \.self.id,content: {
                            movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieTileView(movie: movie)
                            }
                        })
                }
            }.navigationTitle("Movies").background(Color.black).navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.inline/*@END_MENU_TOKEN@*/).toolbar {
                ToolbarItem(placement: .principal) {
                    VStack{
                        Text("Movies")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                }
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
