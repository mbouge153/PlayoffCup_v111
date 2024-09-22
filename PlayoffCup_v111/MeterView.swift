//
//  MeterView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 10/14/23.
//

import SwiftUI

struct MeterView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                HStack {
                    Spacer()
//                    Text("\(gameState.hitMeter)")
                    Text("🗯️")
                        .font(.system(size: 25))
                    ZStack {
                        HStack {
                            Color(red: 0.5, green: 0.5, blue: 0.5)
                                .frame(width: 336, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                        }
                        Button {
                            if gameState.hitMeter > 7 && gameState.enableHitMeter == false {
                                gameState.enableHitMeter = true
                                gameState.hitMeter -= 8
                            }
                        } label: {
                            HStack {
                                if gameState.hitMeter > 7 {
                                    gameState.highlightColor
                                        .frame(width: CGFloat(gameState.hitMeter) * 14, height: 20)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                
                                if gameState.hitMeter <= 7 {
                                    Color(red: 0.7, green: 0.7, blue: 0.7)
                                        .frame(width: CGFloat(gameState.hitMeter) * 14, height: 20)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Spacer()
                            }
                        }
                        HStack {
                            if gameState.hitMeter > 7 {
                                Text("T")
                                Text("A")
                                Text("P")
                                Text(" ")
                                Text("T")
                                Text("O")
                                Text(" ")
                                Text("B")
                                Text("L")
                                Text("O")
                                Text("C")
                                Text("K")
                            }
                            
                            if gameState.hitMeter <= 7 {
                                Text("H")
                                Text("I")
                                Text("T")
                                Text(" ")
                                Text("M")
                                Text("E")
                                Text("T")
                                Text("E")
                                Text("R")
                            }
                        }
//                        .frame(width: 343)
//                        .background(.ultraThinMaterial)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        Spacer()
                    }
                    .frame(width: 336)
                    Text("🚫")
                        .font(.system(size: 25))
                        .saturation(gameState.enableHitMeter == true ? 1.0 : 0.0)
                    Spacer()
                    
                }

                
                HStack {
//                    Text("\(gameState.momentum)")
                    Text(gameState.playerTeam.mascot)
                        .font(.system(size: 25))
                    ZStack {
                        HStack {
                            LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: gameState.playerTeam.firstColor, location: (Double(gameState.momentum) / 100) - 0.05),
                                Gradient.Stop(color: gameState.aiTeam.firstColor, location: (Double(gameState.momentum) / 100) + 0.05),
                            ]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 336, height: 20)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        HStack {
                            Text("M")
//                                .foregroundStyle(.secondary)
                            Text("O")
//                                .foregroundStyle(.secondary)
                            Text("M")
//                                .foregroundStyle(.secondary)
                            Text("E")
//                                .foregroundStyle(.secondary)
                            Text("N")
//                                .foregroundStyle(.secondary)
                            Text("T")
//                                .foregroundStyle(.secondary)
                            Text("U")
//                                .foregroundStyle(.secondary)
                            Text("M")
//                                .foregroundStyle(.secondary)
                        }
                        .frame(width: 336)
//                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Text(gameState.aiTeam.mascot)
                        .font(.system(size: 25))
                    
                }
            }
            
            VStack {
                Button {
                    if gameState.powerPlays > 0 && gameState.skatersLeft < 6 {
                        gameState.enablePowerPlay = true
                    }
                } label: {
                    Text("⚡️")
                        .font(.system(size: 35))
                        .saturation(gameState.powerPlays > 0 ? 1.0 : 0.0)
                }
                
                Text("x\(gameState.powerPlays)")
                    .font(.headline.weight(.heavy))
                    .foregroundStyle(gameState.highlightColor)
            }
        }
    }
}

#Preview {
    MeterView(gameState: GameState())
}
