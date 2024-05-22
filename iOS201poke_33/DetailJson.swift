//
//  DetailJson.swift
//  iOS201poke_33
//
//  Created by OLIVER LIAO on 2024/5/3.
//

import Foundation

//
//struct PokemonSpecies: Decodable {
//    struct NameEntry: Decodable {
//        struct Language: Decodable {
//            var name: String
//        }
//        var language: Language
//        var name: String
//    }
//    var names: [NameEntry]
//}
//
//
//// API 獲取到的數據
//let pokemonData = PokemonSpecies(names: [
//    .init(language: .init(name: "ja"), name: "ギルガルド")
//])
//
//// jpname
//func findJapaneseName(from data: PokemonSpecies) -> String? {
//    for nameEntry in data.names {
//        if nameEntry.language.name == "ja" {
//            return nameEntry.name
//        }
//    }
//    return nil // 如果找不到日文名字，返回 nil
//}
//
//
//
//class DetailJson: ObservableObject {
//    
//    @Published var JpnameList: [String] = []
//    
//    func Jpname() async {
//        for id in 1...1025 {
//                    guard let jpname_url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/") else { continue }
//            
//            do {
//                let (jpname_data, _) = try await URLSession.shared.data(from: jpname_url)
//                let decode = try JSONDecoder().decode(PokemonSpecies.self, from: jpname_data)
//                
//                DispatchQueue.main.async {
//                    self.JpnameList.append(contentsOf: decode.names.filter { $0.language.name == "ja" }.map { $0.name })
//                }
//            } catch {
//                print("error")
//            }
//        }
//    }
//}
