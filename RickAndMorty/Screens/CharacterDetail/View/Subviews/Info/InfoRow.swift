//
//  InfoRow.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct InfoRow: View {
    
    var title: String
    var value: String
    
    private let textFont: Font = .gilroyMedium(16)
    private let verticalPadding: CGFloat = 16
    private let rowHeight: CGFloat = 40
    
    var body: some View {
        HStack {
            makeText(title, color: UIColor.secondaryTextColor.toColor(), withPaddingEdge: .leading)
            Spacer()
            makeText(value, color: UIColor.mainTextColor.toColor(), withPaddingEdge: .trailing)
        }
        .frame(height: rowHeight)
    }
    
    private func makeText(_ text: String, color: Color, withPaddingEdge paddingEdge: Edge.Set) -> some View {
        return Text(text)
            .font(textFont)
            .foregroundColor(color)
            .padding(paddingEdge, verticalPadding)
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(title: "Species:", value: "Human")
            .background(UIColor.cellBackgroundColor.toColor())
    }
}
