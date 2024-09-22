//
//  Series.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/4/23.
//

import Foundation
import SwiftUI

struct Series {
    var teams = [Team]()
    var games = [Game]()
    
    @State private var lastGameId: Int = 0
    
    var team1SeriesScore: Int {
        var temp = 0
        for i in (0..<self.games.count) {
            if games[i].team1FinalScore > games[i].team2FinalScore {
                if temp < 4 {
                    temp += 1
                    if temp == 4 {
                        return 4
                    }
                }
            }
        }
        return temp
    }
    
    var team2SeriesScore: Int {
        var temp = 0
        for i in (0..<self.games.count) {
            if games[i].team1FinalScore < games[i].team2FinalScore {
                if temp < 4 {
                    temp += 1
                    if temp == 4 {
                        return 4
                    }
                }
            }
        }
        return temp
    }
    
    init(teams: [Team]) {
        self.teams = teams
        self.games.removeAll(keepingCapacity: true)
//        self.games.append(Game(gameNumber: 1))
    }
    
    init(teams: [Team], playerSeries: Bool) {
        self.teams = teams
        self.games.removeAll(keepingCapacity: true)
        if playerSeries == false {
//            self.games.append(Game(gameNumber: 1))
        }
    }
    
    func displaySeries() -> String {
        var tempString = ""
        
        if team1SeriesScore > team2SeriesScore {
            tempString = team1SeriesScore == 4 ? "\(teams[0].teamName) Win \(team1SeriesScore) - \(team2SeriesScore)" : "\(teams[0].teamName) Lead \(team1SeriesScore) - \(team2SeriesScore)"
        } else if team1SeriesScore < team2SeriesScore {
            tempString = team2SeriesScore == 4 ? "\(teams[1].teamName) Win \(team1SeriesScore) - \(team2SeriesScore)" : "\(teams[1].teamName) Lead \(team1SeriesScore) - \(team2SeriesScore)"
        } else {
            tempString = "Series Tied \(team1SeriesScore) - \(team2SeriesScore)"
        }
        
        return tempString
    }
    
    func getWinner() -> Team {
        if team1SeriesScore == 4 {
            return teams[0]
        } else {
            return teams[1]
        }
    }
    
    mutating func nextGame(gameNumber: Int) {
        lastGameId += 1
//        if self.games.count != 1 {
            self.games.append(Game(gameNumber: self.games.count + 1))
//        }
    }
    
    mutating func nextGame(team1Score: Int, team2Score: Int, gameNumber: Int) {
        lastGameId += 1
        self.games.append(Game(team1Score: team1Score, team2Score: team2Score, gameNumber: self.games.count + 1))
    }
    
    mutating func playerGame(team1Score: Int, team2Score: Int) {
        if self.games.isEmpty {
            self.games.append(Game(team1Score: team1Score, team2Score: team2Score, gameNumber: self.games.count))
        }
    }
}
