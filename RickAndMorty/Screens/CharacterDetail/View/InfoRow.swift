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
    
    var body: some View {
        HStack {
            Text(title)
                .font(textFont)
                .foregroundColor(UIColor.secondaryTextColor.toColor())
                .padding(.leading, 16)
            Spacer()
            Text(value)
                .font(textFont)
                .foregroundColor(.white)
                .padding(.trailing, 16)
        }
        .frame(height: 40)
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(title: "Species:", value: "Human")
            .background(UIColor.cellBackgroundColor.toColor())
    }
}
