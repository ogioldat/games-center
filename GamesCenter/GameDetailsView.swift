//
//  GameDetailsView.swift
//  GamesCenter
//
//  Created by Tomek Ogiołda on 11/05/2023.
//

import SwiftUI

struct GameDetailsView: View {
    var game: Game
    
    var body: some View {
        if (game.name.lowercased() == "snake") {
            SnakeView()
        }
        if (game.name.lowercased() == "tictactoe") {
            TicTacToeView()
        }
    }
}

struct GameDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailsView(game: games[0])
    }
}
