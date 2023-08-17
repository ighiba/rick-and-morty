//
//  CharacterInfoContainer.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterInfoContainer: View {
    
    var species: String
    var type: String
    var gender: String
    
    private let verticalSpacing: CGFloat = 20
    private let horizontalSpacing: CGFloat = 8
    private let cornerRadius: CGFloat = 16
    
    private let headerFont: Font = .gilroySemibold(17)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Info")
                .font(headerFont)
                .foregroundColor(.white)
                .alignmentGuide(.leading, computeValue: { _ in -verticalSpacing })
                .padding(.bottom, horizontalSpacing)
            
            VStack {
                InfoRow(title: "Species:", value: species)
                InfoRow(title: "Type:", value: type)
                InfoRow(title: "Gender:", value: gender)
            }
            .padding([.top, .bottom], horizontalSpacing)
            .background(UIColor.cellBackgroundColor.toColor())
            .cornerRadius(cornerRadius)
            .padding([.leading, .trailing], verticalSpacing)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CharacterInfoContainer_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInfoContainer(species: "Human", type: "None", gender: "Male")
    }
}
