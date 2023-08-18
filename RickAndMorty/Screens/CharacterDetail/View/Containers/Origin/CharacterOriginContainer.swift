//
//  CharacterOriginContainer.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterOriginContainer: View {
    
    @Binding var originContainer: CharacterModel.OriginContainer
    
    private let originImageHeight: CGFloat = 64
    
    private let verticalSpacing: CGFloat = 8
    private let interTextSpacing: CGFloat = 4
    private let imagePadding: CGFloat = 12
    
    private let cornerRadius: CGFloat = 16
    private let imageCornerRadius: CGFloat = 10
    
    private let originNameFont: Font = .gilroySemibold(17)
    private let originTypeFont: Font = .gilroyMedium(13)
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleHeader(title: "Origin", verticalSpacing: verticalSpacing)
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: .originPlanet)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: originImageHeight, height: originImageHeight)
                        .cornerRadius(imageCornerRadius)
                        .padding(imagePadding)
                    VStack(alignment: .leading) {
                        Text(originContainer.location?.name ?? "Unknown")
                            .font(originNameFont)
                            .foregroundColor(UIColor.mainTextColor.toColor())
                            .padding(.bottom, interTextSpacing)
                        Text(originContainer.location?.type ?? "Unknown")
                            .font(originTypeFont)
                            .foregroundColor(UIColor.greenAccentColor.toColor())
                    }
                    Spacer()
                }
            }
            .background(UIColor.cellBackgroundColor.toColor())
            .cornerRadius(cornerRadius)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CharacterOriginContainer_Previews: PreviewProvider {
    
    static let sampleData = CharacterModel.OriginContainer(
        url: URL(string: "https://rickandmortyapi.com/api/location/1")!,
        location: Location(id: 0, name: "Earth (C-137)", type: "Planet")
    )
    
    static var previews: some View {
        CharacterOriginContainer(originContainer: .constant(sampleData))
    }
}
