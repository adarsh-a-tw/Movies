//
//  RatingView.swift
//  Movies
//
//  Created by Adarsh A on 12/09/22.
//

import SwiftUI

struct RatingView: View {
    private let rating: Int
    private let maxRating = 5
    
    init(rating: Float) {
        self.rating = Int((rating/2).rounded())
    }
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { number in
                Image(systemName: "star.fill")
                    .foregroundColor(number > rating ? .gray : .yellow)
                }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let rating: Float = 7
        RatingView(rating: rating)
    }
}
