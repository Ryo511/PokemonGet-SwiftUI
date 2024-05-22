//
//  Text1.swift
//  iOS201poke_33
//
//  Created by OLIVER LIAO on 2024/5/5.
//

import Foundation

struct poketext: Decodable {
    var name: String
    var imageURL: String?
    var jpName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "front_default"
        case names
    }
    
    enum NameCodingKeys: String, CodingKey {
        case language, name
    }
    
    enum LanguageCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        
        if let namesNestedContainer = try container.nestedUnkeyedContainerIfPresent(forKey: .names) {
            var namesContainer = namesNestedContainer
            while !namesContainer.isAtEnd {
                let nameContainer = try namesContainer.nestedContainer(keyedBy: NameCodingKeys.self)
                let languageContainer = try nameContainer.nestedContainer(keyedBy: LanguageCodingKeys.self, forKey: .language)
                let lang = try languageContainer.decode(String.self, forKey: .name)
                if lang == "ja" {
                    jpName = try nameContainer.decodeIfPresent(String.self, forKey: .name)
                    break
                }
            }
        }
    }
}


class Text1: ObservableObject {
    @Published var pokemons = [poketext]()
    
    func loadPokemonData() async {
        let urlStrings = ["https://pokeapi.co/api/v2/pokemon/1", "https://pokeapi.co/api/v2/pokemon/2"] // 等等
        for urlString in urlStrings {
            guard let url = URL(string: urlString) else { continue }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let pokemon = try JSONDecoder().decode(poketext.self, from: data)
                DispatchQueue.main.async {
                    self.pokemons.append(pokemon)
                }
            } catch {
                print("無法取得或解碼寶可夢數據：\(error)")
            }
        }
    }
}
