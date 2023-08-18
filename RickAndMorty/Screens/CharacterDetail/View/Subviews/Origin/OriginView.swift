//
//  OriginView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct OriginView: View {
    
    @Binding var originContainer: CharacterModel.OriginContainer
    
    private let viewHeight: CGFloat = 80
    private let originImageHeight: CGFloat = 64
    
    private let horizontalPadding: CGFloat = 12
    private let bottomMinSpacing: CGFloat = 14
    
    private let cornerRadius: CGFloat = 16
    private let imageCornerRadius: CGFloat = 10
    
    private let originNameFont: Font = .gilroySemibold(17)
    private let originTypeFont: Font = .gilroyMedium(13)
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleHeader(title: "Origin")
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: .originPlanet)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: originImageHeight, height: originImageHeight)
                        .cornerRadius(imageCornerRadius)
                        .padding(horizontalPadding)
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(originContainer.location?.name ?? "Unknown")
                            .font(originNameFont)
                            .foregroundColor(UIColor.mainTextColor.toColor())
                        Spacer(minLength: 1)
                        Text(originContainer.location?.type ?? "Unknown")
                            .font(originTypeFont)
                            .foregroundColor(UIColor.greenAccentColor.toColor())
                        Spacer(minLength: bottomMinSpacing)
                    }
                    .padding(.trailing, horizontalPadding)
                    Spacer()
                }
            }
            .frame(height: viewHeight)
            .background(UIColor.cellBackgroundColor.toColor())
            .cornerRadius(cornerRadius)
        }
        .frame(maxWidth: .infinity)
    }
}

struct OriginView_Previews: PreviewProvider {
    
    static let sampleData = CharacterModel.OriginContainer(
        url: URL(string: "https://rickandmortyapi.com/api/location/1")!,
        location: Location(id: 0, name: "Earth (Replacement Dimension)", type: "Planet")
    )
    
    static var previews: some View {
        OriginView(originContainer: .constant(sampleData))
            .frame(width: 350)
    }
}
