//
//  RatingView.swift
//  Movies
//
//  Created by Adarsh A on 12/09/22.
//

import SwiftUI

struct RatingView: View {
    private let rating: Float
    private let maxRating = 5
    
    init(rating: Float) {
        self.rating = rating/2.0
    }
    
    
    var body: some View {
     HStack {
        ForEach(1...maxRating, id: \.self) { number in
            let difference = Float(number) - rating
            if Float(number) < rating {
                 star.foregroundColor(.yellow)
            }
            else if difference >= 1.0 {
                 star.foregroundColor(.gray)
            }
            else {
                ZStack(alignment:.leading) {
                     star.foregroundColor(.gray)
                        .overlay(
                            GeometryReader {
                                reader in
                                Rectangle().foregroundColor(.yellow).frame(width: CGFloat(1 - difference)*reader.size.width)
                            }
                            
                        )
                        .mask(star)
                }
        }
        }
    }

    }
    
   
    private var star: some View {
        Image(systemName: "star.fill")
    }
}

struct RatingView_Previews: PreviewProvider {
    
    static var previews: some View {
        RatingView(rating: 7.0)
    }
}
