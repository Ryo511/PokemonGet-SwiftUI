//
//  PokeJsonData.swift
//  iOS201poke_33
//
//  Created by OLIVER LIAO on 2024/4/23.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    var jpname: String?
    var flavor_text: String?
    let sprites: Sprites
    
    var image: URL {
        URL(string: sprites.frontDefault)!
    }
    
    var backimage: URL {
        URL(string: sprites.backDefault)!
    }
    
    var frontshiny: URL {
        URL(string: sprites.frontshiny)!
    }
}

struct Sprites: Codable {
    let frontDefault: String
    let backDefault: String
    let frontshiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case frontshiny = "front_shiny"
    }
}

struct pokejpname: Codable {
    struct Names: Codable {
        struct Language: Codable {
            var name: String
        }
        var language: Language
        var name: String
    }
    var names: [Names]
}

struct sound: Codable {
    var cries: Cries
}

struct Cries: Codable {
    let latest: String
    let legacy: String
    
    enum CodingKeys: String, CodingKey {
        case latest = "latest"
        case legacy = "legacy"
    }
}




class PokeJsonData: ObservableObject {
    
    @Published var pokemonList: [Pokemon] = []
    func getPokemon() async {
        let random = (1...5).map { _ in Int.random(in: 1...1025) }
        
        for id in random{
            guard let reqURL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/"),
                  let speciesURL = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/") else { continue }
            
            do {
                async let (pokemonData, _) = URLSession.shared.data(from: reqURL)
                async let (speciesData, _) = URLSession.shared.data(from: speciesURL)
                
                let (pokemonDataResolved, speciesDataResolved) = await (try? pokemonData, try? speciesData)
                
                if let pokemonData = pokemonDataResolved, let speciesData = speciesDataResolved {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: pokemonData)
                    let species = try JSONDecoder().decode(pokejpname.self, from: speciesData)
                    
                    let jpName = findJapaneseName(from: species)
                    
                    
                    DispatchQueue.main.async {
                        var updatedPokemon = pokemon
                        updatedPokemon.jpname = jpName
                        self.pokemonList.append(updatedPokemon)
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func findJapaneseName(from data: pokejpname) -> String? {
        for entry in data.names where entry.language.name == "ja" {
            return entry.name
        }
        return nil
    }
}


