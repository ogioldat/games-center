//
//  GameTile.swift
//  GamesCenter
//
//  Created by Tomek Ogiołda on 11/05/2023.
//

import SwiftUI

struct GameTile: View {
    var game: Game
    
    var body: some View {
        HStack{
            VStack{
                Text(game.icon).font(.largeTitle)
                Text(game.name).bold().font(.headline)
            }
        }
    }
}

struct GameTile_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            GameTile(game: games[0])
        }
    }
}
