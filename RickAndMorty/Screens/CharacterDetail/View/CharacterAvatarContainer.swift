//
//  CharacterAvatar.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterAvatarContainer: View {
    
    var imageContainer: ImageContainer?
    var name: String
    var status: String
    
    private let avatarHeight: CGFloat = 148
    private let cornerRadius: CGFloat = 16
    
    private let nameFont: Font = .gilroyBold(22)
    private let statusFont: Font = .gilroyMedium(16)
    
    var body: some View {
        VStack {
            VStack {
                if let characterImage = imageContainer?.image {
                    Image(uiImage: characterImage)
                        .frame(width: avatarHeight, height: avatarHeight)
                } else {
                    AsyncImage(url: imageContainer?.url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: avatarHeight, height: avatarHeight)
                    } placeholder: {
                        Image(uiImage: .characterAvatarPlaceholder)
                    }
                }
            }
            .cornerRadius(cornerRadius)
            VStack {
                Text(name)
                    .font(nameFont)
                    .padding(.bottom, 8)
                Text(status)
                    .font(statusFont)
                    .foregroundColor(UIColor.greenAccentColor.toColor())
            }
            .padding(.top, 24)
        }
    }
}

struct CharacterAvatar_Previews: PreviewProvider {
    
    static let sampleImageContainer = ImageContainer(
        URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        nil
    )
    
    static var previews: some View {
        CharacterAvatarContainer(
            imageContainer: sampleImageContainer,
            name: "Rick Sanchez",
            status: "Alive"
        )
    }
}
