//
//  ContentView.swift
//  Snake
//
//  Created by Tomek Ogiołda on 10/05/2023.
//

import SwiftUI


struct GamesCenterView: View {
    var body: some View {
        NavigationStack {
            List(games, id: \.name) { game in
                NavigationLink {
                    GameDetailsView(game: game)
                } label: {
                    GameTile(game: game)
                }
            }
            .navigationTitle("Games Center")
        }
    }
}

struct GamesCenterView_Previews: PreviewProvider {
    static var previews: some View {
        GamesCenterView()

    }
}
