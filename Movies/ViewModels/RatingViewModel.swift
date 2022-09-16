//
//  RatingViewModel.swift
//  Movies
//
//  Created by Adarsh A on 16/09/22.
//

import SwiftUI

struct RatingViewModel {
    private let rating: Float
    private let maxRating = 5
    var stars: [AnyView] = []
    
    init(rating: Float) {
        self.rating = rating/2.0
        makeStars()
    }
    
    private mutating func makeStars(){
        for number in 1...5 {
            let difference = Float(number) - rating
            if Float(number) < rating {
                stars.append(goldStar)
            }
            else if difference >= 1.0 {
                stars.append(grayStar)
            }
            else {
                stars.append(generatePartialFilledStar(toFill: 1 - difference))
            }
        }
    }
    
    private var star: some View {
        Image(systemName: "star.fill")
    }
    
    private var goldStar: AnyView {
        AnyView(star.foregroundColor(.yellow))
    }
    
    private var grayStar: AnyView {
        AnyView(star.foregroundColor(.gray))
    }
    
    private func generatePartialFilledStar(toFill: Float) -> AnyView {
        AnyView(
            ZStack(alignment:.leading) {
                star
                .foregroundColor(.gray)
                .overlay(
                    GeometryReader {
                        reader in
                        Rectangle()
                            .foregroundColor(.yellow)
                            .frame(width: CGFloat(toFill) * reader.size.width)
                    }
                )
                .mask(star)
            }
        )
    }

}


