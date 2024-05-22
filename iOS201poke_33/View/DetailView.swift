//
//  DetailView.swift
//  iOS201poke_33
//
//  Created by OLIVER LIAO on 2024/5/7.
//

import SwiftUI
import Foundation

struct flavor_text_entries: Decodable {
    var flavor_text: String
    struct Language: Decodable {
        var name: String
    }
    var language: Language
    var name: String
    struct version: Decodable {
        var name: String
    }
    var flavor_text_entries: [flavor_text_entries]
}

class Detail: ObservableObject {
    @Published var flavorList: [flavor_text_entries] = []
    
    func getflavor() async {
        for id in 1...1025 {
            guard let flavor_url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/") else { continue }
            
            do {
                async let (flavorData, _) = URLSession.shared.data(from: flavor_url)
                
                let flavorDataResolved = await (try? flavorData)
                
                if let flavorData = flavorDataResolved {
                    let flavor = try JSONDecoder().decode(flavor_text_entries.self, from: flavorData)
                    
                    var updateflavor = flavor
                    updateflavor.flavor_text_entries = flavorname(from: flavor)
                    
                    DispatchQueue.main.async {
                        self.flavorList.append(updateflavor)
                    }
                }
            } catch {
                print("Error")
            }
        }
    }
    
    private func updateflavor(from data: )
}


struct DetailView: View {
    var body: some View {
        ScrollView {
            
        }
    }
}

#Preview {
    DetailView()
}
