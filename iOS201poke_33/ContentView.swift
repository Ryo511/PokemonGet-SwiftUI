//
//  ContentView.swift
//  iOS201poke_33
//
//  Created by OLIVER LIAO on 2024/4/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var poke = PokeJsonData()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Text("23CM0133 廖博鏞")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    Task {
                        await poke.getPokemon()
                    }
                }) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                }
                
                
                List(poke.pokemonList, id: \.self.name) { pokemon in
                    HStack {
                        AsyncImage(url: pokemon.image) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        NavigationLink(pokemon.jpname ?? pokemon.name) {
                            ZStack {
                                VStack {
                                    AsyncImage(url: pokemon.image) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 300)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .background(
                                    Rectangle()
                                        .fill(Color.pink.opacity(0.7))
                                        .frame(width: 300, height: 200)
                                        .cornerRadius(20)
                                    )
                                    
                                    AsyncImage(url: pokemon.backimage) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 300)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .background(
                                        Rectangle()
                                            .fill(Color.green.opacity(0.7))
                                            .frame(width: 300, height: 200)
                                            .cornerRadius(20)
                                    )
                                
                                    HStack {
                                        Text(pokemon.jpname ?? pokemon.name)
                                            .font(.system(size: 30))
                                            .foregroundColor(Color.brown.opacity(0.8))
                                    }
                                }
                            }
                            .bold()
                            .font(.system(size: 17))
                            .offset(x: 10)
                        }
                    }
                    .listRowBackground(Color.brown.opacity(0.8))
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.yellow.opacity(0.7))
        }
    }
}




#Preview {
    ContentView()
}
