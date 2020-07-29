//
//  Game.swift
//  TicTacToe
//
//  Created by David Williams on 7/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

enum GameState {
    case active(GameBoard.Mark) // Active player
    case cat
    case won(GameBoard.Mark) // Winning player
}

struct Game {
    
    mutating internal func restart() {
        gameViewController.board = GameBoard()
        gameViewController.gameState = .active(.x)
    }
    
    mutating internal func makeMark(at coordinate: Coordinate)  throws {
        guard case let .active(player) = gameState else {
            NSLog("Game is over")
            return
        }
        do {
            try board.place(mark: player, on: coordinate)
            if game(board: board, isWonBy: player) {
                gameState = .won(player)
            } else if board.isFull {
                gameState = .cat
            } else {
                let newPlayer = player == .x ? GameBoard.Mark.o : GameBoard.Mark.x
                gameState = .active(newPlayer)
            }
        } catch {
            NSLog("Illegal move")
        }
//        boardViewController.updateButtons()
    }
    
    private(set) var board: GameBoard {
        didSet {
            boardViewController.board = board
        }
    }
    
    var gameViewController = GameViewController()
    
    var boardViewController = BoardViewController()
    
    internal var activePlayer: GameBoard.Mark?
    internal var gameIsOver :Bool
    internal var winningPlayer: GameBoard.Mark?
//    var gameState: GameState?
    var gameState = GameState.active(.x)
}
