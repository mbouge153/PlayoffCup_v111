//
//  Schedule.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/21/23.
//

import Foundation
import SwiftUI

class Schedule: ObservableObject {
    @Published var match1: Match
    @Published var match2: Match
    @Published var match3: Match
    @Published var match4: Match
    @Published var match5: Match
    @Published var match6: Match
    @Published var match7: Match
    @Published var match8: Match
    
    init() {
        let nun = Team(teamID: "NUN", teamName: "Octopuses", teamLocation: "Nunavut",
                       country: "🇨🇦", mascot: "🐙", division: .north, conference: .rival,
                       firstColor: Color(red: 0.639, green: 0.149, blue: 0.294))
        self.match1 = Match(teams: [nun, nun])
        self.match2 = Match(teams: [nun, nun])
        self.match3 = Match(teams: [nun, nun])
        self.match4 = Match(teams: [nun, nun])
        self.match5 = Match(teams: [nun, nun])
        self.match6 = Match(teams: [nun, nun])
        self.match7 = Match(teams: [nun, nun])
        self.match8 = Match(teams: [nun, nun])
    }
    
    func advanceGames(gameState: GameState) {
        if match1.continueSeries {
            if gameState.playerTeam.division == .north {
                match1.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else if gameState.series == 2 && gameState.playerTeam.division == .east {
                match1.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else if gameState.series == 3 && gameState.playerTeam.division == .east {
                match1.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else if gameState.series == 3 && gameState.playerTeam.conference == .valor {
                match1.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else {
                match1.series.nextGame(gameNumber: gameState.game)
            }
        }
        if match2.continueSeries {
            match2.series.nextGame(gameNumber: gameState.game)
        }
        if match3.continueSeries {
            if gameState.playerTeam.division == .east {
                match3.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else {
                match3.series.nextGame(gameNumber: gameState.game)
            }
        }
        if match4.continueSeries {
            match4.series.nextGame(gameNumber: gameState.game)
        }
        if match5.continueSeries {
            if gameState.playerTeam.division == .south {
                match5.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else if gameState.series == 2 && gameState.playerTeam.division == .west {
                match5.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else {
                match5.series.nextGame(gameNumber: gameState.game)
            }
        }
        if match6.continueSeries {
            match6.series.nextGame(gameNumber: gameState.game)
        }
        if match7.continueSeries {
            if gameState.playerTeam.division == .west {
                match7.series.nextGame(team1Score: gameState.playerFinalGameScore, team2Score: gameState.aiFinalGameScore, gameNumber: gameState.game)
            } else {
                match7.series.nextGame(gameNumber: gameState.game)
            }
        }
        if match8.continueSeries {
            match8.series.nextGame(gameNumber: gameState.game)
        }
    }

    func matchMaking(gameState: GameState) {
        var northTeams = [Team]()
        var eastTeams = [Team]()
        var southTeams = [Team]()
        var westTeams = [Team]()
        
        for i in (0..<gameState.allTeams.count) {
            switch gameState.allTeams[i].division {
            case .north:
                northTeams.append(gameState.allTeams[i])
            
            case .east:
                eastTeams.append(gameState.allTeams[i])
            
            case .south:
                southTeams.append(gameState.allTeams[i])
            
            case .west:
                westTeams.append(gameState.allTeams[i])
            }
        }
        
        if gameState.series == 0 {
            switch gameState.playerTeam.division {
            case .north:
                for i in (0..<northTeams.count) {
                    if northTeams[i].teamID == gameState.playerTeam.teamID {
                        northTeams.remove(at: i)
                        break
                    }
                }
                northTeams.shuffle()
                gameState.aiTeam = northTeams[0]
                northTeams.remove(at: 0)
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match2 = Match(teams: [northTeams[0], northTeams[1]], playerMatch: false)
                
                eastTeams.shuffle()
                self.match3 = Match(teams: [eastTeams[0], eastTeams[1]], playerMatch: false)
                self.match4 = Match(teams: [eastTeams[2], eastTeams[3]], playerMatch: false)
                
                southTeams.shuffle()
                self.match5 = Match(teams: [southTeams[0], southTeams[1]], playerMatch: false)
                self.match6 = Match(teams: [southTeams[2], southTeams[3]], playerMatch: false)
                
                westTeams.shuffle()
                self.match7 = Match(teams: [westTeams[0], westTeams[1]], playerMatch: false)
                self.match8 = Match(teams: [westTeams[2], westTeams[3]], playerMatch: false)
                
            case .east:
                for i in (0..<eastTeams.count) {
                    if eastTeams[i].teamID == gameState.playerTeam.teamID {
                        eastTeams.remove(at: i)
                        break
                    }
                }
                eastTeams.shuffle()
                gameState.aiTeam = eastTeams[0]
                eastTeams.remove(at: 0)
                self.match3 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match4 = Match(teams: [eastTeams[0], eastTeams[1]], playerMatch: false)
                
                northTeams.shuffle()
                self.match1 = Match(teams: [northTeams[0], northTeams[1]], playerMatch: false)
                self.match2 = Match(teams: [northTeams[2], northTeams[3]], playerMatch: false)
                
                southTeams.shuffle()
                self.match5 = Match(teams: [southTeams[0], southTeams[1]], playerMatch: false)
                self.match6 = Match(teams: [southTeams[2], southTeams[3]], playerMatch: false)
                
                westTeams.shuffle()
                self.match7 = Match(teams: [westTeams[0], westTeams[1]], playerMatch: false)
                self.match8 = Match(teams: [westTeams[2], westTeams[3]], playerMatch: false)
                
            case .south:
                for i in (0..<southTeams.count) {
                    if southTeams[i].teamID == gameState.playerTeam.teamID {
                        southTeams.remove(at: i)
                        break
                    }
                }
                southTeams.shuffle()
                gameState.aiTeam = southTeams[0]
                southTeams.remove(at: 0)
                self.match5 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match6 = Match(teams: [southTeams[0], southTeams[1]], playerMatch: false)
                
                northTeams.shuffle()
                self.match1 = Match(teams: [northTeams[0], northTeams[1]], playerMatch: false)
                self.match2 = Match(teams: [northTeams[2], northTeams[3]], playerMatch: false)
                
                eastTeams.shuffle()
                self.match3 = Match(teams: [eastTeams[0], eastTeams[1]], playerMatch: false)
                self.match4 = Match(teams: [eastTeams[2], eastTeams[3]], playerMatch: false)
                
                westTeams.shuffle()
                self.match7 = Match(teams: [westTeams[0], westTeams[1]], playerMatch: false)
                self.match8 = Match(teams: [westTeams[2], westTeams[3]], playerMatch: false)

            case .west:
                for i in (0..<westTeams.count) {
                    if westTeams[i].teamID == gameState.playerTeam.teamID {
                        westTeams.remove(at: i)
                        break
                    }
                }
                westTeams.shuffle()
                gameState.aiTeam = westTeams[0]
                westTeams.remove(at: 0)
                self.match7 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match8 = Match(teams: [westTeams[0], westTeams[1]], playerMatch: false)
                
                northTeams.shuffle()
                self.match1 = Match(teams: [northTeams[0], northTeams[1]], playerMatch: false)
                self.match2 = Match(teams: [northTeams[2], northTeams[3]], playerMatch: false)
                
                eastTeams.shuffle()
                self.match3 = Match(teams: [eastTeams[0], eastTeams[1]], playerMatch: false)
                self.match4 = Match(teams: [eastTeams[2], eastTeams[3]], playerMatch: false)
                
                southTeams.shuffle()
                self.match5 = Match(teams: [southTeams[0], southTeams[1]], playerMatch: false)
                self.match6 = Match(teams: [southTeams[2], southTeams[3]], playerMatch: false)
                
            }
        } else if gameState.series == 1 {
            switch gameState.playerTeam.division {
            case .north:
                let winnerNorth = match2.series.getWinner()
                let winnerEast1 = match3.series.getWinner()
                let winnerEast2 = match4.series.getWinner()
                let winnerSouth1 = match5.series.getWinner()
                let winnerSouth2 = match6.series.getWinner()
                let winnerWest1 = match7.series.getWinner()
                let winnerWest2 = match8.series.getWinner()
                
                gameState.aiTeam = winnerNorth
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match3 = Match(teams: [winnerEast1, winnerEast2], playerMatch: false)
                self.match5 = Match(teams: [winnerSouth1, winnerSouth2], playerMatch: false)
                self.match7 = Match(teams: [winnerWest1, winnerWest2], playerMatch: false)
                
            case .east:
                let winnerNorth1 = match1.series.getWinner()
                let winnerNorth2 = match2.series.getWinner()
                let winnerEast = match4.series.getWinner()
                let winnerSouth1 = match5.series.getWinner()
                let winnerSouth2 = match6.series.getWinner()
                let winnerWest1 = match7.series.getWinner()
                let winnerWest2 = match8.series.getWinner()
                
                gameState.aiTeam = winnerEast
                self.match1 = Match(teams: [winnerNorth1, winnerNorth2], playerMatch: false)
                self.match3 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match5 = Match(teams: [winnerSouth1, winnerSouth2], playerMatch: false)
                self.match7 = Match(teams: [winnerWest1, winnerWest2], playerMatch: false)
                
            case .south:
                let winnerNorth1 = match1.series.getWinner()
                let winnerNorth2 = match2.series.getWinner()
                let winnerEast1 = match3.series.getWinner()
                let winnerEast2 = match4.series.getWinner()
                let winnerSouth = match6.series.getWinner()
                let winnerWest1 = match7.series.getWinner()
                let winnerWest2 = match8.series.getWinner()
                
                gameState.aiTeam = winnerSouth
                self.match1 = Match(teams: [winnerNorth1, winnerNorth2], playerMatch: false)
                self.match3 = Match(teams: [winnerEast1, winnerEast2], playerMatch: false)
                self.match5 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match7 = Match(teams: [winnerWest1, winnerWest2], playerMatch: false)

            case .west:
                let winnerNorth1 = match1.series.getWinner()
                let winnerNorth2 = match2.series.getWinner()
                let winnerEast1 = match3.series.getWinner()
                let winnerEast2 = match4.series.getWinner()
                let winnerSouth1 = match5.series.getWinner()
                let winnerSouth2 = match6.series.getWinner()
                let winnerWest = match8.series.getWinner()
                
                gameState.aiTeam = winnerWest
                self.match1 = Match(teams: [winnerNorth1, winnerNorth2], playerMatch: false)
                self.match3 = Match(teams: [winnerEast1, winnerEast2], playerMatch: false)
                self.match5 = Match(teams: [winnerSouth1, winnerSouth2], playerMatch: false)
                self.match7 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                
            }
        } else if gameState.series == 2 {
            switch gameState.playerTeam.division {
                
            case .north:
                let winnerEast = match3.series.getWinner()
                let winnerSouth = match5.series.getWinner()
                let winnerWest = match7.series.getWinner()
                
                gameState.aiTeam = winnerEast
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match5 = Match(teams: [winnerSouth, winnerWest], playerMatch: false)
                
                
            case .east:
                let winnerNorth = match1.series.getWinner()
                let winnerSouth = match5.series.getWinner()
                let winnerWest = match7.series.getWinner()
                
                gameState.aiTeam = winnerNorth
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                self.match5 = Match(teams: [winnerSouth, winnerWest], playerMatch: false)
                
                
            case .south:
                let winnerNorth = match1.series.getWinner()
                let winnerEast = match3.series.getWinner()
                let winnerWest = match7.series.getWinner()
                
                gameState.aiTeam = winnerWest
                self.match1 = Match(teams: [winnerNorth, winnerEast], playerMatch: false)
                self.match5 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)

                
            case .west:
                let winnerNorth = match1.series.getWinner()
                let winnerEast = match3.series.getWinner()
                let winnerSouth = match5.series.getWinner()
                
                gameState.aiTeam = winnerSouth
                self.match1 = Match(teams: [winnerNorth, winnerEast], playerMatch: false)
                self.match5 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
            }
        } else if gameState.series == 3 {
            switch gameState.playerTeam.division {
            case .north:
                let winnerValor = match5.series.getWinner()
                gameState.aiTeam = winnerValor
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                
            case .east:
                let winnerValor = match5.series.getWinner()
                gameState.aiTeam = winnerValor
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                
            case .south:
                let winnerRival = match1.series.getWinner()
                gameState.aiTeam = winnerRival
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)

            case .west:
                let winnerRival = match1.series.getWinner()
                gameState.aiTeam = winnerRival
                self.match1 = Match(teams: [gameState.playerTeam, gameState.aiTeam], playerMatch: true)
                
            }
        }
    }
    
}
