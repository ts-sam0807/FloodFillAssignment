//
//  Bridge.swift
//  FloodFillAssignment
//
//  Created by Ts SaM on 9/8/2023.
//

import Foundation

// 1 1 1 0 0 0 0 1 1 1
// 1 1 1 1 0 0 0 0 1 1
// 1 0 1 1 0 0 0 0 1 1
// 0 0 1 1 1 0 0 0 0 1
// 0 0 0 1 0 0 0 0 0 1
// 0 0 0 0 0 0 0 0 0 1
// 0 0 0 0 0 0 0 0 0 0
// 0 0 0 0 1 1 0 0 0 0
// 0 0 0 0 1 1 1 0 0 0
// 0 0 0 0 0 0 0 0 0 0

func bridge() {
    
    let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
    
    func shortestBridge(_ grid: [[Int]]) -> Int {
        let n = grid.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: n)
        var queue = Queue<(row: Int, col: Int, dist: Int)>()

        var found = false
        for row in 0..<n {
            if found {
                break;
            }
            for col in 0..<n {
                if grid[row][col] == 1 {
                    dfs(&visited, &queue, grid, row, col)
                    found = true
                    break;
                }
            }
        }

        while !queue.isEmpty() {
            let (row, col, dist) = queue.dequeue()!
            for direction in directions {
                let newRow = row + direction.0
                let newCol = col + direction.1
//                print(newRow)
//                print(newCol)
                if newRow >= 0 && newRow < n && newCol >= 0 && newCol < n && !visited[newRow][newCol] {
                    if grid[newRow][newCol] == 1 {
                        return dist
                    }
                    visited[newRow][newCol] = true
                    queue.enqueue(item: (newRow, newCol, dist + 1))
                }
            }
        }

        return 0
    }

    func dfs(_ visited: inout [[Bool]], _ queue: inout Queue<(row: Int, col: Int, dist: Int)>, _ grid: [[Int]], _ row: Int, _ col: Int) {
//        print(row)
//        print(col)
        if row < 0 || row >= grid.count || col < 0 || col >= grid.count || visited[row][col] || grid[row][col] == 0 {
            return
        }
        visited[row][col] = true
    
        queue.enqueue(item: (row, col, 0))
        for direction in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            dfs(&visited, &queue, grid, row + direction.0, col + direction.1)
        }
    }

    let n = Int(readLine()!)!
    var grid = [[Int]]()
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        grid.append(row)
    }

    let result = shortestBridge(grid)
    print(result)
}
