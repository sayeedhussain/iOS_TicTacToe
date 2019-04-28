
import Foundation
import UIKit

enum GameMoveResult: Int {
    case Continue
    case Finished
    case InvalidSelection
}

enum GameStatus: Int {
    case Playing
    case Finished
}

class GameViewModel{
    
    private var gameBoard = Array<Array<String>>()
    private var gameStatus: GameStatus = .Playing
    private var currentPlayer = "X"
    let dimensions = 3
    
    init() {
        self.gameBoard = Array<Array<String>>(repeating: Array<String>(repeating: "-", count: dimensions), count: dimensions)
    }
    
    func winner() -> String? {
        if gameStatus == .Finished {
            return currentPlayer
        }
        return nil
    }
    
    func updateGameState(indexPath: IndexPath) -> GameMoveResult {
        if !isSelectableIndexPath(indexPath: indexPath) {
            return .InvalidSelection
        }
        setCurrentPlayer()
        updateGameBoard(indexPath: indexPath)
        gameStatus = gameStatus(indexPath: indexPath)
        return gameStatus == GameStatus.Finished ? GameMoveResult.Finished : GameMoveResult.Continue
    }
    
    func setCurrentPlayer() {
        if self.currentPlayer == "X" {
            self.currentPlayer = "O"
        }
        else {
            self.currentPlayer = "X"
        }
    }
    
    func updateGameBoard(indexPath: IndexPath) {
        self.gameBoard[indexPath.section][indexPath.row] = self.currentPlayer
    }

    func titleValueFor(indexPath: IndexPath) -> String {
        return self.gameBoard[indexPath.section][indexPath.row]
    }
    
    func isSelectableIndexPath(indexPath: IndexPath) -> Bool {
        return self.gameBoard[indexPath.section][indexPath.row] == "-"
    }
    
    func gameStatus(indexPath: IndexPath) -> GameStatus {
                
        //Checking Row Wise
        if let status = checkRowWise(), status == .Finished {
            return .Finished
        }

        //Checking Column Wise
        if let status = checkColumnWise(), status == .Finished {
            return .Finished
        }

        //Checking Diagnol Wise
        if let status = checkDiagonalWise(), status == .Finished {
            return .Finished
        }
        
        return .Playing
    }
    
    //can simplify this further
    private func checkRowWise() -> GameStatus? {
        for (_, item) in gameBoard.enumerated() {
            var winningTileRowCount = 0
            for value in item {
                if (currentPlayer == value) {
                    winningTileRowCount += 1
                }
            }
            if (winningTileRowCount == dimensions) {
                return .Finished
            }
        }
        return nil
    }
    
    //can simplify this further
    private func checkColumnWise() -> GameStatus? {
        for column in 0 ..< dimensions {
            var winningTileCountColumnWise = 0
            for row in 0 ..< dimensions {
                if (currentPlayer == gameBoard[row][column]) {
                    winningTileCountColumnWise += 1
                }
            }
            if (winningTileCountColumnWise == dimensions) {
                return .Finished
            }
        }
        return nil
    }
    
    //can simplify this further
    private func checkDiagonalWise() -> GameStatus? {
        var winningTileCountDiagnalWise = 0
        for column in 0 ..< dimensions {
            for row in 0 ..< dimensions {
                if (row == column) {
                    if (currentPlayer == gameBoard[row][column]) {
                        winningTileCountDiagnalWise += 1
                    }
                }
                if (winningTileCountDiagnalWise == dimensions) {
                    return .Finished
                }
            }
        }
        return nil
    }
}
