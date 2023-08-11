//
//  Tomato.swift
//  FloodFillAssignment
//
//  Created by Ts SaM on 9/8/2023.
//

import Foundation

func tomato() {
    struct Square {
        let row: Int
        let col: Int
    }

    func isValid(_ row: Int, _ col: Int, _ rows: Int, _ cols: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < cols
    }

    func minimumDaysToRipen(_ grid: inout [[Int]]) -> Int {
        let rows = grid.count
        let cols = grid[0].count
        
        var days = 0
        var freshTomatoes = 0
        let q = Queue<Square>()
        
        for i in 0..<rows {
            for j in 0..<cols {
                if grid[i][j] == 1 {
                    q.enqueue(item: (Square(row: i, col: j)))
                } else if grid[i][j] == 0 {
                    freshTomatoes += 1
                }
            }
        }
        
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        
        while !q.isEmpty() {
            let size = q.count
            
            for _ in 0..<size {
                let square = q.dequeue()!
                
                for dir in directions {
                    let newRow = square.row + dir.0
                    let newCol = square.col + dir.1
                    
                    if isValid(newRow, newCol, rows, cols) && grid[newRow][newCol] == 0 {
                        grid[newRow][newCol] = 1
                        freshTomatoes -= 1
                        q.enqueue(item: (Square(row: newRow, col: newCol)))
                    }
                }
            }
            
            if !q.isEmpty() {
                days += 1
            }
        }
        
        return freshTomatoes == 0 ? days : -1
    }


    let MN = readLine()!.split(separator: " ").map { Int($0)! }
    let M = MN[0]
    let N = MN[1]

    var grid = [[Int]]()
    for _ in 0..<N {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        grid.append(row)
    }

    let result = minimumDaysToRipen(&grid)
    print(result)

}
