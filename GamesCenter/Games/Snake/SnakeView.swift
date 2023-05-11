//
//  ContentView.swift
//  Snake
//
//  Created by Tomek Ogiołda on 10/05/2023.
//

import SwiftUI

struct SnakeView: View {
    @State var startPos : CGPoint = .zero
    @State var isStarted = true
    @State var gameOver = false
    @State var dir = Direction.down
    @State var posArray = [CGPoint(x: 0, y: 0)]
    @State var foodPos = CGPoint(x: 0, y: 0)
    
    let snakeSize : CGFloat = 20
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    let minX = UIScreen.main.bounds.minX
    let maxX = UIScreen.main.bounds.maxX
    let minY = UIScreen.main.bounds.minY
    let maxY = UIScreen.main.bounds.maxY

    func changeRectPos() -> CGPoint {
        let rows = Int(maxX/snakeSize)
        let cols = Int(maxY/snakeSize)
        
        let randomX = Int.random(in: 1..<rows) * Int(snakeSize)
        let randomY = Int.random(in: 1..<cols) * Int(snakeSize)
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    func changeDirection () {
        if self.posArray[0].x < minX || self.posArray[0].x > maxX && !gameOver{
            gameOver.toggle()
        }
        else if self.posArray[0].y < minY || self.posArray[0].y > maxY  && !gameOver {
            gameOver.toggle()
        }
        var prev = posArray[0]
        if dir == .down {
            self.posArray[0].y += snakeSize
        } else if dir == .up {
            self.posArray[0].y -= snakeSize
        } else if dir == .left {
            self.posArray[0].x += snakeSize
        } else {
            self.posArray[0].x -= snakeSize
        }
        
        for index in 1..<posArray.count {
            let current = posArray[index]
            posArray[index] = prev
            prev = current
        }
    }

    var body: some View {
        ZStack {
            if(self.gameOver) {
                Color.red.opacity(0.5)
            } else {
                Color.orange.opacity(0.3)
            }
                
            ZStack {
                ForEach (0..<posArray.count, id: \.self) { index in
                    Rectangle()
                        .fill(Color.green.opacity(0.8))
                        .frame(width: self.snakeSize, height: self.snakeSize)
                        .position(self.posArray[index])
                }
                Rectangle()
                    .fill(Color.brown.opacity(0.8))
                    .frame(width: snakeSize, height: snakeSize)
                    .position(foodPos)
            }.onAppear() {
                self.foodPos = self.changeRectPos()
                self.posArray[0] = self.changeRectPos()
           }
            
            if self.gameOver {
                VStack{
                    Text("🐍☠️").font(.title)
                    Text("Game Over").font(.title).fontWeight(.semibold).opacity(0.7)
                }
            }
        }
        .gesture(DragGesture()
        .onChanged { gesture in
            if self.isStarted {
                self.startPos = gesture.location
                self.isStarted.toggle()
            }
        }
        .onEnded {  gesture in
            let xDist =  abs(gesture.location.x - self.startPos.x)
            let yDist =  abs(gesture.location.y - self.startPos.y)
            if self.startPos.y <  gesture.location.y && yDist > xDist {
                self.dir = Direction.down
            }
            else if self.startPos.y >  gesture.location.y && yDist > xDist {
                self.dir = Direction.up
            }
            else if self.startPos.x > gesture.location.x && yDist < xDist {
                self.dir = Direction.right
            }
            else if self.startPos.x < gesture.location.x && yDist < xDist {
                self.dir = Direction.left
            }
            self.isStarted.toggle()
            }
        )
        .onReceive(timer) { (_) in
          if !self.gameOver {
               self.changeDirection()
               if self.posArray[0] == self.foodPos {
                    self.posArray.append(self.posArray[0])
                     self.foodPos = self.changeRectPos()
            }
          }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SnakeView_Previews: PreviewProvider {
    static var previews: some View {
        SnakeView()
    }
}
