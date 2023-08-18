//
//  TitleHeader.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

private let headerFont: Font = .gilroySemibold(17)

struct TitleHeader: View {
    
    var title: String
    var leadingPadding: CGFloat
    var bottomPadding: CGFloat

    init(title: String, leadingPadding: CGFloat = 2, bottomPadding: CGFloat = 8) {
        self.title = title
        self.leadingPadding = leadingPadding
        self.bottomPadding = bottomPadding
    }
    
    var body: some View {
        Text(title)
            .font(headerFont)
            .foregroundColor(UIColor.mainTextColor.toColor())
            .alignmentGuide(.leading, computeValue: { _ in -leadingPadding })
            .padding(.bottom, bottomPadding)
    }
}

struct TitleHeader_Previews: PreviewProvider {
    static var previews: some View {
        TitleHeader(title: "Header", leadingPadding: 20, bottomPadding: 8)
            .background(UIColor.cellBackgroundColor.toColor())
    }
}
