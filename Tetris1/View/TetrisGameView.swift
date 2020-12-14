//
//  TetrisGameView.swift
//  Tetris1
//
//  Created by Darsh Gondalia on 12/05/20.
//  Copyright © 2020 Darsh Gondalia. All rights reserved.
//

import SwiftUI

struct TetrisGameView: View {
    @ObservedObject var tetrisGame = TetrisGameViewModel()
    
    var body: some View {
        
        GeometryReader { (geometry: GeometryProxy) in
            self.drawBoard(boundingRect: geometry.size)
        }
        .gesture(tetrisGame.getMoveGesture())
        .gesture(tetrisGame.getRotateGesture())
    }
    
    func drawBoard(boundingRect: CGSize) -> some View {
        let columns = self.tetrisGame.numColumns
        let rows = self.tetrisGame.numRows
        let blocksize = min(boundingRect.width/CGFloat(columns*3/2), boundingRect.height/CGFloat(rows*3/2))
        let xoffset = (boundingRect.width - blocksize*CGFloat(columns))/2
        let yoffset = (boundingRect.height - blocksize*CGFloat(rows))/2
        let gameBoard = self.tetrisGame.gameBoard
        
        return ForEach(0...columns-1, id:\.self) { (column:Int) in
            ForEach(0...rows-1, id:\.self) { (row:Int) in
                Path { path in
                    let y = yoffset + blocksize * CGFloat(row)
                    let x = boundingRect.width - xoffset - blocksize*CGFloat(column+1)
                    
                    //let rect = CGRect(x: x, y: y, width: blocksize, height: blocksize)
                    
                    path.move(to: CGPoint(x:x, y: y))
                    path.addLine(to: CGPoint(x: x, y: y+blocksize))
                    path.addLine(to: CGPoint(x: x+blocksize, y: y+blocksize))
                    path.addLine(to: CGPoint(x: x+blocksize, y: y))
                    //path.addRect(rect)
                }.fill(gameBoard[column][row].color)
            }
        }
    }
}


struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
