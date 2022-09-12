//
//  MovieDetailView.swift
//  Movies
//
//  Created by Adarsh A on 12/09/22.
//

import SwiftUI

struct MovieDetailView: View {
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: movie.logoURL)) { phase in
                if let image = phase.image {
                    image.resizable().cornerRadius(15)
                }
                else if phase.error != nil {
                    
                }
                else {
                    ProgressView().foregroundColor(.orange)
                }
            }.aspectRatio(2/3,contentMode: .fit)
            Text(movie.title).font(.largeTitle).foregroundColor(.orange).multilineTextAlignment(.center).padding()
            RatingView(rating: movie.rating).padding()
            Text(movie.description).padding().foregroundColor(Color.white)
        }.background(Color.black).padding(0)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(
            movie: Movie(
                id: "1",
                title: "El Camino' Cooks Up 'Breaking Bad' Easter Eggs",
                description: "On this spoiler-filled IMDbrief, we break bad and break down the Breaking Bad finale part two: 'El Camino' (2019).",
                logoURL: "https://upload.wikimedia.org/wikipedia/en/4/4e/El_camino_bb_film_poster.jpg",
                rating: 7.1))
    }
}
