//
//  GameSummaryView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/10/23.
//

import SwiftUI

struct GameSummaryView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var gameState: GameState
    @ObservedObject var schedule: Schedule
    
    var gameStatus: String {
        if gameState.playerFinalGameScore > gameState.aiFinalGameScore {
            return "won"
        } else {
            return "lost"
        }
    }
    
    var section1Label: String {
        switch gameState.series {
        case 0:
            return "North Division Semifinals"
        case 1:
            return "North Division Final"
        case 2:
            return "Rival Confernce Final"
        case 3:
            return "Playoff Cup Final"
        default:
            fatalError("Series out of range")
        }
    }
    
    var section2Label: String {
        switch gameState.series {
        case 0:
            return "East Division Semifinals"
        case 1:
            return "East Division Final"
        case 2:
            return "Rival Confernce Final"
        case 3:
            return "Playoff Cup Final"
        default:
            fatalError("Series out of range")
        }
    }
    
    var section3Label: String {
        switch gameState.series {
        case 0:
            return "South Division Semifinals"
        case 1:
            return "South Division Final"
        case 2:
            return "Valor Confernce Final"
        case 3:
            return "Playoff Cup Final"
        default:
            fatalError("Series out of range")
        }
    }
    
    var section4Label: String {
        switch gameState.series {
        case 0:
            return "West Division Semifinals"
        case 1:
            return "West Division Final"
        case 2:
            return "Valor Confernce Final"
        case 3:
            return "Playoff Cup Final"
        default:
            fatalError("Series out of range")
        }
    }
    
    var body: some View {
        VStack(spacing: 2) {
//            RadialGradient(gradient: Gradient(stops: [
//                .init(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 0.05),
//                .init(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 0.15),
//                .init(color: .black, location: 0.70),
//            ]), center: .bottom, startRadius: 60, endRadius: 900)
//            .ignoresSafeArea()
            
//            Text("")
//            Text("")
            HStack {
                Spacer()
                Text("\(gameState.playerTeam.teamName) \(gameStatus) game \(gameState.game)!")
                    .font(.title3.weight(.bold))
                    .textCase(.uppercase)
                    .italic()
                Spacer()
                Button {
                    if gameState.playerSeriesScore == 4 {
                        gameState.game = 1
                        gameState.playerSeriesScore = 0
                        gameState.aiSeriesScore = 0
                        if gameState.series == 3 {
                            gameState.series = 0
                        } else {
                            gameState.series += 1
                        }
                        schedule.matchMaking(gameState: gameState)
                    } else if gameState.aiSeriesScore == 4 {
                        gameState.game = 1
                        gameState.playerSeriesScore = 0
                        gameState.aiSeriesScore = 0
                        gameState.series = 0
                        schedule.matchMaking(gameState: gameState)
                    } else {
                        gameState.game += 1
                    }
                    dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(gameState.highlightColor, lineWidth: 4)
                            .frame(width: 160, height: 40)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        Text("CONTINUE")
                            .font(.title2.weight(.bold))
                            .foregroundStyle(gameState.highlightColor)
                            .padding(10)
                    }
                }
            }
            
            ScrollView {
                VStack {
//                    Text("")
                    HStack {
                        Spacer()
                        ZStack {
                            Color.gray
                                .frame(width: .infinity, height: 25)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            HStack {
                                if gameState.series < 2 {
                                    Spacer()
                                    Text("Rival Conference")
                                        .font(.title3.weight(.bold))
                                        .italic()
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 12)
                                } else if gameState.series == 2 {
                                    Text("Rival Conference Final")
                                        .font(.title3.weight(.bold))
                                        .italic()
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 12)
                                    Spacer()
                                } else {
                                    Text("Playoff Cup Final")
                                        .font(.title3.weight(.bold))
                                        .italic()
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 12)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                    if gameState.series < 2 {
                        HStack {
                            Text(section1Label)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    
                    if gameState.playerTeam.division == .north {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match1.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match2.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match1.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 3 {
                            HStack {
                                Spacer()
                                schedule.match1.displayMatch()
                                    .padding(3)
                                Spacer()
                            }
                        }
                    } else {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                schedule.match1.displayMatch()
                                    .padding(3)
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match2.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 2 && gameState.playerTeam.division != .east {
                            HStack {
                                Spacer()
                                schedule.match1.displayMatch()
                                    .padding(3)
                                Spacer()
                            }
                        }
//                        } else if gameState.series == 3 {
//                            HStack {
//                                Spacer()
//                                schedule.match1.displayMatch()
//                                        .padding(3)
//                                Spacer()
//                            }
//                        }
                    }

                    Text("")
                    if gameState.series < 2 {
                        HStack {
                            Text(section2Label)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    
                    if gameState.playerTeam.division == .east {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match3.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match4.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match1.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 3 {
                            HStack {
                                Spacer()
                                schedule.match1.displayMatch()
                                    .padding(3)
                                Spacer()
                            }
                        }
                    } else {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                schedule.match3.displayMatch()
                                    .padding(3)
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match4.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        }
//                        } else if gameState.series == 2 {
//                            HStack {
//                                Spacer()
//                                schedule.match1.displayMatch()
//                                    .padding(3)
//                                Spacer()
//                            }
//                        } else if gameState.series == 3 {
//                            HStack {
//                                Spacer()
//                                schedule.match1.displayMatch()
//                                    .padding(3)
//                                Spacer()
//                            }
//                        }
                    }
                    
                    if gameState.series != 3 {
                        Text("")
                        Text("")
                        HStack {
                            Spacer()
                            ZStack {
                                Color.gray
                                    .frame(width: .infinity, height: 25)
                                    .background(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                HStack {
                                    if gameState.series < 2 {
                                        Spacer()
                                        Text("Valor Conference")
                                            .font(.title3.weight(.bold))
                                            .italic()
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 12)
                                    } else if gameState.series == 2 {
                                        Text("Valor Conference Final")
                                            .font(.title3.weight(.bold))
                                            .italic()
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 12)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    
                    if gameState.series < 2 {
                        HStack {
                            Text(section3Label)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    
                    if gameState.playerTeam.division == .south {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match5.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match6.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match5.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 3 {
                            HStack {
                                Spacer()
                                schedule.match1.displayMatch()
                                    .padding(3)
                                Spacer()
                            }
                        }
                    } else {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                schedule.match5.displayMatch()
                                    .padding(3)
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match6.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 2 && gameState.playerTeam.division != .west {
                            HStack {
                                Spacer()
                                schedule.match5.displayMatch()
                                    .padding(3)
                                Spacer()
                            }
                        }
                    }
                    
                    Text("")
                    if gameState.series < 2 {
                        HStack {
                            Text(section4Label)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    
                    if gameState.playerTeam.division == .west {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match7.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match8.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 2 {
                            HStack {
                                Spacer()
                                ZStack {
                                    Color.clear
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(gameState.highlightColor, lineWidth: 4))
                                        .opacity(1.0)
                                    schedule.match5.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        } else if gameState.series == 3 {
                            HStack {
                                Spacer()
                                schedule.match1.displayMatch()
                                    .padding(3)
                                Spacer()
                            }
                        }
                    } else {
                        if gameState.series < 2 {
                            HStack {
                                Spacer()
                                schedule.match7.displayMatch()
                                    .padding(3)
                                Spacer()
                                if gameState.series < 1 {
                                    schedule.match8.displayMatch()
                                        .padding(3)
                                }
                                Spacer()
                            }
                        }
//                        } else if gameState.series == 2 {
//                            HStack {
//                                Spacer()
//                                schedule.match5.displayMatch()
//                                    .padding(3)
//                                Spacer()
//                            }
//                        }
                    }
                    
                    
//                    Text("")
//                    Text("")
//                    Button {
//                        if gameState.playerSeriesScore == 4 {
//                            gameState.game = 1
//                            gameState.playerSeriesScore = 0
//                            gameState.aiSeriesScore = 0
//                            if gameState.series == 3 {
//                                gameState.series = 0
//                            } else {
//                                gameState.series += 1
//                            }
//                            schedule.matchMaking(gameState: gameState)
//                        } else if gameState.aiSeriesScore == 4 {
//                            gameState.game = 1
//                            gameState.playerSeriesScore = 0
//                            gameState.aiSeriesScore = 0
//                            gameState.series = 0
//                            schedule.matchMaking(gameState: gameState)
//                        } else {
//                            gameState.game += 1
//                        }
//                        dismiss()
//                    } label: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .strokeBorder(gameState.highlightColor, lineWidth: 4)
//                                .frame(width: 250, height: 40)
//                                .background(.black)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                            Text("CONTINUE")
//                                .font(.title2.weight(.bold))
//                                .foregroundStyle(gameState.highlightColor)
//                                .padding(10)
//                        }
//                    }
                }
            }
            .padding(10)
        }
        .onAppear {
            schedule.match1.animate()
            schedule.match2.animate()
            schedule.match3.animate()
            schedule.match4.animate()
            schedule.match5.animate()
            schedule.match6.animate()
            schedule.match7.animate()
            schedule.match8.animate()
        }
    }
}

struct GameSummaryView_Previews: PreviewProvider {
    static var nun = Team(teamID: "NUN", teamName: "Octopuses", teamLocation: "Nunavut",
                   country: "🇨🇦", mascot: "🐙", division: .north, conference: .rival,
                   firstColor: Color(red: 0.639, green: 0.149, blue: 0.294))
    
    static var previews: some View {
        GameSummaryView(gameState: GameState(), schedule: Schedule())
    }
}
