//
//  RatingView.swift
//  Movies
//
//  Created by Adarsh A on 12/09/22.
//

import SwiftUI

struct RatingView: View {
    private let viewModel : RatingViewModel
    
    init(rating: Float) {
        self.viewModel = RatingViewModel(rating: rating)
    }
    
    var body: some View {
        HStack {
            ForEach(0..<viewModel.stars.count,id: \.self) {
                 viewModel.stars[$0]
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 7.0)
    }
}
