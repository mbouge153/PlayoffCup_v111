//
//  SeriesSummaryView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 10/7/23.
//

import SwiftUI

struct SeriesSummaryView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var gameState: GameState
    @ObservedObject var schedule: Schedule
    
    @State private var opacityAmount = 0.0
    @State private var scaleAmount = 0.0
    @State private var flipAnimation = 0.0
    
    var seriesWinSymbol: String {
        switch gameState.series {
        case 3:
            return "🏆"
        case 2:
            return "🥇"
        case 1:
            return "🏅"
        default:
            return "✅"
        }
    }
    
    var seriesWinMessage: String {
        switch gameState.series {
        case 3:
            return "\(gameState.playerTeam.teamName) Won the Playoff Cup!"
        case 2:
            return "\(gameState.playerTeam.teamName) are the \(gameState.playerTeam.conference.rawValue.capitalized) Conference Champions!"
        case 1:
            return "\(gameState.playerTeam.teamName) are the \(gameState.playerTeam.division.rawValue.capitalized) Division Champions!"
        default:
            return "\(gameState.playerTeam.teamName) Advance to the \(gameState.playerTeam.division.rawValue.capitalized) Division Final!"
        }
    }
    
    var seriesLoseMessage: String {
        switch gameState.series {
        case 3:
            return "\(gameState.playerTeam.teamName) Lost the Playoff Cup Final"
        case 2:
            return "\(gameState.playerTeam.teamName) Lost the \(gameState.playerTeam.conference.rawValue.capitalized) Conference Final"
        case 1:
            return "\(gameState.playerTeam.teamName) Lost the \(gameState.playerTeam.division.rawValue.capitalized) Division Final"
        default:
            return "\(gameState.playerTeam.teamName) Lost the \(gameState.playerTeam.division.rawValue.capitalized) Series"
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                if gameState.playerSeriesScore == 4 {
                    Text("Congratulations, You Won the Series!")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                    HStack {
                        Text(seriesWinSymbol)
                            .font(.system(size: 180))
                            .rotation3DEffect(.degrees(flipAnimation), axis: (x: 0.0, y: 1.0, z: 0.0))
                        
                        Text(seriesWinMessage)
                            .font(.system(size: 40).weight(.bold))
                            .foregroundStyle(gameState.highlightColor)
                            .frame(width: 380)
                            .scaleEffect(scaleAmount)
                    }
                } else if gameState.aiSeriesScore == 4 {
                    Text("Oh No, You Lost the Series!")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                    HStack {
                        Text("❌")
                            .font(.system(size: 180))
                        
                        Text(seriesLoseMessage)
                            .font(.system(size: 40).weight(.bold))
                            .foregroundStyle(gameState.highlightColor)
                            .frame(width: 380)
                    }
                }
                    
                    
//                    if gameState.playerSeriesScore == 4 {
//                        VStack {
//                            Text("You won the series!")
//                            Button("Continue") {
//                                if gameState.game == 4 {
//                                    schedule.advanceGames(gameState: gameState)
//                                    schedule.advanceGames(gameState: gameState)
//                                    schedule.advanceGames(gameState: gameState)
//                                } else if gameState.game == 5 {
//                                    schedule.advanceGames(gameState: gameState)
//                                    schedule.advanceGames(gameState: gameState)
//                                } else if gameState.game == 6 {
//                                    schedule.advanceGames(gameState: gameState)
//                                }
//                                gameState.showGameSummary = true
//                                dismiss()
//                            }
//                        }
//                    } else if gameState.aiSeriesScore == 4 {
//                        Text("You lost the series.")
//                        Button("Continue") {
//                            if gameState.game == 4 {
//                                schedule.advanceGames(gameState: gameState)
//                                schedule.advanceGames(gameState: gameState)
//                                schedule.advanceGames(gameState: gameState)
//                            } else if gameState.game == 5 {
//                                schedule.advanceGames(gameState: gameState)
//                                schedule.advanceGames(gameState: gameState)
//                            } else if gameState.game == 6 {
//                                schedule.advanceGames(gameState: gameState)
//                            }
//                            gameState.showGameSummary = true
//                            dismiss()
//                        }
//                    }
//                }
                
                Button {
                    if gameState.game == 4 {
                        schedule.advanceGames(gameState: gameState)
                        schedule.advanceGames(gameState: gameState)
                        schedule.advanceGames(gameState: gameState)
                    } else if gameState.game == 5 {
                        schedule.advanceGames(gameState: gameState)
                        schedule.advanceGames(gameState: gameState)
                    } else if gameState.game == 6 {
                        schedule.advanceGames(gameState: gameState)
                    }
                    gameState.showGameSummary = true
                    dismiss()
                } label: {
                    ZStack {
                        Text("CONTINUE")
                            .font(.title2.weight(.bold))
                            .foregroundStyle(.white)
//                            .background(gameState.highlightColor)
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                    }
                }
                .opacity(opacityAmount)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 3).delay(0).repeatForever(autoreverses: false)) {
                    flipAnimation += 360
                }
                withAnimation(.easeInOut(duration: 2).delay(0)) {
                    scaleAmount = 1.0
                }
                withAnimation(.easeInOut(duration: 3).delay(3)) {
                    opacityAmount = 1.0
                }
            }
        }
    }
}

#Preview {
    SeriesSummaryView(gameState: GameState(), schedule: Schedule())
}
