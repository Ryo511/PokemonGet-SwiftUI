//
//  TextView.swift
//  iOS201poke_33
//
//  Created by OLIVER LIAO on 2024/5/5.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var detailJson = Text1()
    
    var body: some View {
        List(detailJson.pokemons, id: \.name) { pokemon in
            HStack {
                AsyncImage(url: URL(string: pokemon.imageURL ?? .init())) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(pokemon.name)
                    if let jpName = pokemon.jpName {
                        Text(jpName)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await detailJson.loadPokemonData()
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
