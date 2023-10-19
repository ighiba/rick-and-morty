//
//  CharacterAvatar.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

private let avatarHeight: CGFloat = 148

private let nameTopPadding: CGFloat = 20
private let nameBottomPadding: CGFloat = 1

private let nameFont: Font = .gilroyBold(22)
private let statusFont: Font = .gilroyMedium(16)

struct AvatarView: View {
    
    @Binding var characterAvatar: CharacterModel.Avatar
    
    private let cachedImageLoader = CachedImageLoader.shared

    private let cornerRadius: CGFloat = 16
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                makeAvatarImage(forUrl: characterAvatar.imageUrl)
            }
            .cornerRadius(cornerRadius)
            VStack {
                Text(characterAvatar.name)
                    .font(nameFont)
                    .foregroundColor(UIColor.mainTextColor.toColor())
                    .padding(.top, nameTopPadding)
                    .padding(.bottom, nameBottomPadding)
                Text(characterAvatar.status)
                    .font(statusFont)
                    .foregroundColor(UIColor.greenAccentColor.toColor())
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func makeAvatarImage(forUrl url: URL?) -> some View {
        if let imageUrl = url, let cachedImage = cachedImageLoader.cachedImage(forUrl: imageUrl) {
            resizeAvatarImage { Image(uiImage: cachedImage) }
        } else {
            AsyncImage(url: url) { image in
                resizeAvatarImage { image }
            } placeholder: {
                Image(uiImage: .characterAvatarPlaceholder)
            }
        }
    }
    
    private func resizeAvatarImage(image: () -> Image) -> some View {
        return image()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: avatarHeight, height: avatarHeight)
    }
}

struct AvatarView_Previews: PreviewProvider {
    
    static let sampleData = CharacterModel.Avatar(
        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        name: "Rick Sanchez",
        status: "Alive"
    )
    
    static var previews: some View {
        AvatarView(characterAvatar: .constant(sampleData))
            .background(UIColor.defaultBackgroundColor.toColor())
    }
}
