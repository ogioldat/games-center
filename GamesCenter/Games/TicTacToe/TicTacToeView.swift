import SwiftUI

struct TicTacToeView : View {
    @State var moves : [String] = Array(repeating: "", count: 9)
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3),spacing: 15){
                
                ForEach(0..<9,id: \.self){index in
                    ZStack {
                        Color.blue
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white )
                            .opacity(moves[index] != "" ? 1 : 0)
                    }
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(25)
                    .onTapGesture(perform: {
        
                            if moves[index] == ""{
                                moves[index] = isPlaying ? "❌" : "⭕️"
                                isPlaying.toggle()
                            }
                    })
                }
            }
            .padding(15)
        }
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            
            Alert(title: Text("Winner"), message: Text(msg), dismissButton:
                    .destructive(Text("Play Again"), action: {
                withAnimation(Animation.easeIn(duration: 0.5)){
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        })
    }
    
    func getWidth()->CGFloat{
        
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 3
    }
    
    func checkWinner(){
        if checkMoves(player: "❌"){
            msg = "Player ❌ Won !!!"
            gameOver.toggle()
        }
        
        else if checkMoves(player: "⭕️"){
            msg = "Player ⭕️ Won !!!"
            gameOver.toggle()
        }
        else {
            // checking no moves....
            let status = moves.contains { (value) -> Bool in
                return value == ""
            }
            if !status{
                msg = "Game over Tied!!!"
                gameOver.toggle()
            }
        }
    }
    
    func checkMoves(player: String)->Bool{
        // Horizontal moves...
        for i in stride(from: 0, to: 9, by: 3) {
            if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player {
                return true
            }
        }
        
        
        // Vertical moves...
        for i in 0...2 {
            if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player {
                return true
            }
        }
        
        if moves[0] == player && moves[4] == player && moves[8] == player{
            return true
        }
        
        if moves[2] == player && moves[4] == player && moves[6] == player{
            return true
        }
        return false
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}