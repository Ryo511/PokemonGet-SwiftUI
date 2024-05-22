//
//  PokemonDetail.swift
//  iOS201poke_33
//
//  Created by OLIVER LIAO on 2024/5/3.
//

import SwiftUI


struct PokemonDetail: View {
    @StateObject var jpname = DetailJson()

    var body: some View {
        List(jpname.JpnameList, id: \.self) { name in
                    Text(name)
                }
        .onAppear {
                    Task {
                        await jpname.Jpname()
                    }
                }
    }
}

#Preview {
    PokemonDetail()
}
