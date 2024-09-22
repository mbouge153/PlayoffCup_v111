//
//  Game.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/4/23.
//

import Foundation
import SwiftUI

struct Game {
    var gameNumber: Int
    var team1Score: Int = 0
    var team2Score: Int = 0
    var team1FinalScore: Int = 0
    var team2FinalScore: Int = 0
    @State var spinAnimation: Double = 0.0
    
    init(gameNumber: Int) {
        self.gameNumber = gameNumber

        for _ in (0..<15) {
            let temp = Int.random(in: 0...2)
            if temp == 0 {
                self.team1Score += 1
            } else if temp == 1 {
                self.team2Score += 1
            } else { }
        }
        
        while self.team1Score == self.team2Score {
            let temp = Int.random(in: 0...2)
            if temp == 0 {
                self.team1Score += 1
            } else if temp == 1 {
                self.team2Score += 1
            } else { }
        }
        
        self.team1FinalScore = self.team1Score
        self.team2FinalScore = self.team2Score
    }
    
    init(team1Score: Int, team2Score: Int, gameNumber: Int) {
        self.gameNumber = gameNumber
        self.team1FinalScore = team1Score
        self.team2FinalScore = team2Score
    }
    
    func displayGameNumber() -> String {
        return "GAME \(gameNumber)"
    }
    
    func spinWinner() {
        self.spinAnimation += 360
    }
    
    func display(team1: Team, team2: Team, continueSeries: Bool) -> some View {
        if !continueSeries {
            if team1FinalScore > team2FinalScore {
                return VStack {
                    HStack {
                        ZStack {
                            team1.firstColor
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text(team1.mascot)
                                        .font(.system(size: 50))
                                        .saturation(1.0)
                                    Text("\(team1FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                }
                                Text(team1.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team1.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 1, z: 0))
                        }
                        
                        
//                        ZStack {
//                            team1.firstColor
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team1.teamID)")
//                                    .font(.caption2.weight(.semibold))
//                                Text("\(team1.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(1.0)
//                                Text("\(team1FinalScore)")
//                                    .font(.system(size: 25).weight(.bold))
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                        
                        ZStack {
                            Color.gray
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text("\(team2FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                    Text(team2.mascot)
                                        .font(.system(size: 50))
                                        .saturation(0.0)
                                }
                                Text(team2.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team2.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 0, z: 0))
                        }
                        
//                        ZStack {
//                            Color.gray
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team2FinalScore)")
//                                    .font(.system(size: 25))
//                                Text("\(team2.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(0.0)
//                                Text("\(team2.teamID)")
//                                    .font(.caption2)
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                    }
                }
            } else {
                return VStack {
                    HStack {
                        ZStack {
                            Color.gray
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text(team1.mascot)
                                        .font(.system(size: 50))
                                        .saturation(0.0)
                                    Text("\(team1FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                }
                                Text(team1.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team1.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 0, z: 0))
                        }
                        
//                        ZStack {
//                            Color.gray
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team1.teamID)")
//                                    .font(.caption2)
//                                Text("\(team1.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(0.0)
//                                Text("\(team1FinalScore)")
//                                    .font(.system(size: 25))
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                        
                        ZStack {
                            team2.firstColor
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text("\(team2FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                    Text(team2.mascot)
                                        .font(.system(size: 50))
                                        .saturation(1.0)
                                }
                                Text(team2.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team2.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 1, z: 0))
                        }
                        
//                        ZStack {
//                            team2.firstColor
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team2FinalScore)")
//                                    .font(.system(size: 25).weight(.bold))
//                                Text("\(team2.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(1.0)
//                                Text("\(team2.teamID)")
//                                    .font(.caption2.weight(.semibold))
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                    }
                }
            }
        } else {
            if team1FinalScore > team2FinalScore {
                return VStack {
                    HStack {
                        ZStack {
                            team1.firstColor
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text(team1.mascot)
                                        .font(.system(size: 50))
                                        .saturation(1.0)
                                    Text("\(team1FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                }
                                Text(team1.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team1.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 1, z: 0))
                        }
                        
//                        ZStack {
//                            team1.firstColor
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team1.teamID)")
//                                    .font(.caption2.weight(.semibold))
//                                Text("\(team1.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(1.0)
//                                Text("\(team1FinalScore)")
//                                    .font(.system(size: 25).weight(.bold))
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                        
                        ZStack {
                            team2.firstColor
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text("\(team2FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                    Text(team2.mascot)
                                        .font(.system(size: 50))
                                        .saturation(1.0)
                                }
                                Text(team2.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team2.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 0, z: 0))
                        }
                        
//                        ZStack {
//                            team2.firstColor
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team2FinalScore)")
//                                    .font(.system(size: 25))
//                                Text("\(team2.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(1.0)
//                                Text("\(team2.teamID)")
//                                    .font(.caption2)
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                    }
                }
            } else {
                return VStack {
                    HStack {
                        ZStack {
                            team1.firstColor
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text(team1.mascot)
                                        .font(.system(size: 50))
                                        .saturation(1.0)
                                    Text("\(team1FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                }
                                Text(team1.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team1.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 0, z: 0))
                        }
                        
//                        ZStack {
//                            team1.firstColor
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team1.teamID)")
//                                    .font(.caption2)
//                                Text("\(team1.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(1.0)
//                                Text("\(team1FinalScore)")
//                                    .font(.system(size: 25))
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                        
                        ZStack {
                            team2.firstColor
                                .frame(width: 140, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack {
                                    Text("\(team2FinalScore)")
                                        .font(.largeTitle.weight(.black))
                                    Text(team2.mascot)
                                        .font(.system(size: 50))
                                        .saturation(1.0)
                                }
                                Text(team2.teamLocation)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.black)
                                Text(team2.teamName)
                                    .font(.subheadline.weight(.heavy))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 110, height: 100)
                            .padding(3)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 1, z: 0))
                        }
                        
//                        ZStack {
//                            team2.firstColor
//                                .saturation(1.0)
//                                .frame(width: 140, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                            HStack {
//                                Text("\(team2FinalScore)")
//                                    .font(.system(size: 25).weight(.bold))
//                                Text("\(team2.mascot)")
//                                    .font(.system(size: 30))
//                                    .saturation(1.0)
//                                Text("\(team2.teamID)")
//                                    .font(.caption2.weight(.semibold))
//                            }
//                            .frame(width: 120, height: 45)
//                            .background(.regularMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
                    }
                }
            }
        }
    }
}
