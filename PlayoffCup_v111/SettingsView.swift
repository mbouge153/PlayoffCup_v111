//
//  SettingsView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 10/1/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var gameState: GameState
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            
            RadialGradient(gradient: Gradient(stops: [
                .init(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 0.05),
                .init(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 0.15),
                .init(color: .black, location: 0.60),
            ]), center: .bottom, startRadius: 60, endRadius: 900)
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Text("Choose Highlight Color")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(gameState.highlightColor)
                
//                Text(" ")
                
                LazyVGrid(columns: layout) {
                    ForEach(0..<gameState.allTeams.count, id: \.self) { teamColor in
                        Button {
                            gameState.highlightColor = gameState.allTeams[teamColor].firstColor
                            dismiss()
                        } label: {
                            gameState.allTeams[teamColor].firstColor
                                .frame(width: 40, height: 40)
                                .background(gameState.highlightColor)
                                .clipShape(Circle())
                                .padding(4)
                                .background(.black)
                                .clipShape(Circle())
                        }
                    }
                }
                .frame(width: 400)
                
//                HStack {
//                    Spacer()
//                    Text("App by Mark Bourgeois")
//                        .font(.caption)
//                }
                
//                HStack {
//                    VStack {
//                        
//                        Button {
//                            gameState.highlightColor = .yellow
//                            dismiss()
//                        } label: {
//                            Color.yellow
//                                .frame(width: 40, height: 40)
//                                .background(gameState.highlightColor)
//                                .clipShape(Circle())
//                                .padding(4)
//                                .background(.black)
//                                .clipShape(Circle())
//                        }
//                        
//                        Button {
//                            gameState.highlightColor = .blue
//                            dismiss()
//                        } label: {
//                            Color.blue
//                                .frame(width: 40, height: 40)
//                                .background(gameState.highlightColor)
//                                .clipShape(Circle())
//                                .padding(4)
//                                .background(.black)
//                                .clipShape(Circle())
//                        }
//                    }
//                    
//                    VStack {
//                        
//                        Button {
//                            gameState.highlightColor = .pink
//                            dismiss()
//                        } label: {
//                            Color.pink
//                                .frame(width: 40, height: 40)
//                                .background(gameState.highlightColor)
//                                .clipShape(Circle())
//                                .padding(4)
//                                .background(.black)
//                                .clipShape(Circle())
//                        }
//                        
//                        Button {
//                            gameState.highlightColor = .green
//                            dismiss()
//                        } label: {
//                            Color.green
//                                .frame(width: 40, height: 40)
//                                .background(gameState.highlightColor)
//                                .clipShape(Circle())
//                                .padding(4)
//                                .background(.black)
//                                .clipShape(Circle())
//                        }
//                    }
//                    
//                    VStack {
//                        
//                        Button {
//                            gameState.highlightColor = .purple
//                            dismiss()
//                        } label: {
//                            Color.purple
//                                .frame(width: 40, height: 40)
//                                .background(gameState.highlightColor)
//                                .clipShape(Circle())
//                                .padding(4)
//                                .background(.black)
//                                .clipShape(Circle())
//                        }
//                        
//                        Button {
//                            gameState.highlightColor = .orange
//                            dismiss()
//                        } label: {
//                            Color.orange
//                                .frame(width: 40, height: 40)
//                                .background(gameState.highlightColor)
//                                .clipShape(Circle())
//                                .padding(4)
//                                .background(.black)
//                                .clipShape(Circle())
//                        }
//                    }
//                }
            }
        }
    }
}

#Preview {
    SettingsView(gameState: GameState())
}
