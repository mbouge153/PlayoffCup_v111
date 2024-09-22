//
//  TeamSelectionView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/23/23.
//

import SwiftUI

struct TeamSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var gameState: GameState
    @ObservedObject var schedule: Schedule
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Text("Rival Conference: North Division")
                    .font(.headline)
                    .foregroundStyle(.black)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(gameState.allTeams.indices, id: \.self) { i in
                            if gameState.allTeams[i].division == .north {
                                Button {
                                    gameState.playerTeamIndex = i
                                    gameState.playerTeam = gameState.allTeams[gameState.playerTeamIndex]
                                    gameState.highlightColor = gameState.playerTeam.firstColor
                                    schedule.matchMaking(gameState: gameState)
                                    gameState.enableRinkView = true
                                    dismiss()
                                } label: {
                                    ZStack {
                                        gameState.allTeams[i].firstColor
                                            .frame(width: 200, height: 90)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        VStack {
                                            HStack {
                                                VStack {
                                                    Text(gameState.allTeams[i].teamID)
                                                        .font(.caption)
                                                        .foregroundStyle(.black)
                                                    Text(gameState.allTeams[i].country)
                                                }
                                                Text(gameState.allTeams[i].mascot)
                                                    .font(.system(size: 50))
                                            }
                                            Text(gameState.allTeams[i].teamLocation)
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundStyle(.black)
                                            Text(gameState.allTeams[i].teamName)
                                                .font(.subheadline.weight(.heavy))
                                                .foregroundStyle(.black)
                                        }
                                        .frame(width: 130, height: 100)
                                        .padding(10)
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                Spacer()
                
                Text("Rival Conference: East Division")
                    .font(.headline)
                    .foregroundStyle(.black)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(gameState.allTeams.indices, id: \.self) { i in
                            if gameState.allTeams[i].division == .east {
                                Button {
                                    gameState.playerTeamIndex = i
                                    gameState.playerTeam = gameState.allTeams[gameState.playerTeamIndex]
                                    gameState.highlightColor = gameState.playerTeam.firstColor
                                    schedule.matchMaking(gameState: gameState)
                                    gameState.enableRinkView = true
                                    dismiss()
                                } label: {
                                    ZStack {
                                        gameState.allTeams[i].firstColor
                                            .frame(width: 200, height: 90)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        VStack {
                                            HStack {
                                                VStack {
                                                    Text(gameState.allTeams[i].teamID)
                                                        .font(.caption)
                                                        .foregroundStyle(.black)
                                                    Text(gameState.allTeams[i].country)
                                                }
                                                Text(gameState.allTeams[i].mascot)
                                                    .font(.system(size: 50))
                                            }
                                            Text(gameState.allTeams[i].teamLocation)
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundStyle(.black)
                                            Text(gameState.allTeams[i].teamName)
                                                .font(.subheadline.weight(.heavy))
                                                .foregroundStyle(.black)
                                        }
                                        .frame(width: 130, height: 100)
                                        .padding(10)
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                Spacer()
                
                Text("Valor Conference: South Division")
                    .font(.headline)
                    .foregroundStyle(.black)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(gameState.allTeams.indices, id: \.self) { i in
                            if gameState.allTeams[i].division == .south {
                                Button {
                                    gameState.playerTeamIndex = i
                                    gameState.playerTeam = gameState.allTeams[gameState.playerTeamIndex]
                                    gameState.highlightColor = gameState.playerTeam.firstColor
                                    schedule.matchMaking(gameState: gameState)
                                    gameState.enableRinkView = true
                                    dismiss()
                                } label: {
                                    ZStack {
                                        gameState.allTeams[i].firstColor
                                            .frame(width: 200, height: 90)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        VStack {
                                            HStack {
                                                VStack {
                                                    Text(gameState.allTeams[i].teamID)
                                                        .font(.caption)
                                                        .foregroundStyle(.black)
                                                    Text(gameState.allTeams[i].country)
                                                }
                                                Text(gameState.allTeams[i].mascot)
                                                    .font(.system(size: 50))
                                            }
                                            Text(gameState.allTeams[i].teamLocation)
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundStyle(.black)
                                            Text(gameState.allTeams[i].teamName)
                                                .font(.subheadline.weight(.heavy))
                                                .foregroundStyle(.black)
                                        }
                                        .frame(width: 130, height: 100)
                                        .padding(10)
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                Spacer()
                
                Text("Valor Conference: West Division")
                    .font(.headline)
                    .foregroundStyle(.black)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(gameState.allTeams.indices, id: \.self) { i in
                            if gameState.allTeams[i].division == .west {
                                Button {
                                    gameState.playerTeamIndex = i
                                    gameState.playerTeam = gameState.allTeams[gameState.playerTeamIndex]
                                    gameState.highlightColor = gameState.playerTeam.firstColor
                                    schedule.matchMaking(gameState: gameState)
                                    gameState.enableRinkView = true
                                    dismiss()
                                } label: {
                                    ZStack {
                                        gameState.allTeams[i].firstColor
                                            .frame(width: 200, height: 90)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        VStack {
                                            HStack {
                                                VStack {
                                                    Text(gameState.allTeams[i].teamID)
                                                        .font(.caption)
                                                        .foregroundStyle(.black)
                                                    Text(gameState.allTeams[i].country)
                                                }
                                                Text(gameState.allTeams[i].mascot)
                                                    .font(.system(size: 50))
                                            }
                                            Text(gameState.allTeams[i].teamLocation)
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundStyle(.black)
                                            Text(gameState.allTeams[i].teamName)
                                                .font(.subheadline.weight(.heavy))
                                                .foregroundStyle(.black)
                                        }
                                        .frame(width: 130, height: 100)
                                        .padding(10)
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    TeamSelectionView(gameState: GameState(), schedule: Schedule())
}
