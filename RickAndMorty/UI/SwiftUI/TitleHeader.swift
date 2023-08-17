//
//  TitleHeader.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct TitleHeader: View {
    
    var title: String
    var horizontalSpacing: CGFloat
    var verticalSpacing: CGFloat
    
    private let headerFont: Font = .gilroySemibold(17)
    
    var body: some View {
        Text(title)
            .font(headerFont)
            .foregroundColor(.white)
            .alignmentGuide(.leading, computeValue: { _ in -horizontalSpacing })
            .padding(.bottom, verticalSpacing)
    }
}

struct TitleHeader_Previews: PreviewProvider {
    static var previews: some View {
        TitleHeader(title: "Header", horizontalSpacing: 20, verticalSpacing: 8)
    }
}
