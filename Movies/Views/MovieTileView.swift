//
//  MovieTileView.swift
//  Movies
//
//  Created by Adarsh A on 11/09/22.
//

import SwiftUI

struct MovieTileView: View {
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15).foregroundColor(.gray)
            VStack {
                AsyncImage(url: URL(string: movie.logoURL)) { phase in
                    if let image = phase.image {
                    image.resizable().cornerRadius(15)
                    }else if phase.error != nil {
                        Image(systemName: "photo.fill").cornerRadius(15).foregroundColor(.black)
                        Text("Preview not available").foregroundColor(.black).padding()
                    } else {
                        ProgressView()
                    }
                    
                }.aspectRatio(2/3,contentMode: .fit)
            }
        }.aspectRatio(2/3,contentMode: .fit).padding(10)
    }
}


struct MovieTileView_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieTileView(
            movie: Movie(
                id: "1",
                title: "El Camino' Cooks Up 'Breaking Bad' Easter Eggs",
                description: "On this spoiler-filled IMDbrief, we break bad and break down the Breaking Bad finale part two: 'El Camino' (2019).",
                logoURL: "https://upload.wikimedia.org/wikipedia/en/4/4e/El_camino_bb_film_poster.jpg",
                rating: 7.1))
    }
}
