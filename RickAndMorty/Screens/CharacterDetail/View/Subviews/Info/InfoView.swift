//
//  InfoView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

private let verticalPadding: CGFloat = 8

private let headerFont: Font = .gilroySemibold(17)

struct InfoView: View {
    
    @Binding var characterInfo: CharacterModel.Info
    
    private let cornerRadius: CGFloat = 16

    var body: some View {
        VStack(alignment: .leading) {
            TitleHeader(title: "Info")
            VStack {
                InfoRow(title: "Species:", value: characterInfo.species)
                InfoRow(title: "Type:", value: !characterInfo.type.isEmpty ? characterInfo.type : "None")
                InfoRow(title: "Gender:", value: characterInfo.gender)
            }
            .background(UIColor.cellBackgroundColor.toColor())
            .cornerRadius(cornerRadius)
        }
        .frame(maxWidth: .infinity)
    }
}

struct InfoView_Previews: PreviewProvider {
    
    static let sampleData = CharacterModel.Info(species: "Human", type: "None", gender: "Male")
    
    static var previews: some View {
        InfoView(characterInfo: .constant(sampleData))
    }
}
