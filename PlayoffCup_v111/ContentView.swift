//
//  ContentView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/4/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameState = GameState()
    @StateObject var schedule = Schedule()
    
    @State private var showTeamSelection = false
    @State private var showSettings = false
    
    @State private var spinAnimation = 0.0
    @State private var selectTeamAnimation = 0.0
    
    @State private var skaterOpacity = 1.0
    
    var seriesName: String {
        if gameState.series == 0 {
            return "Division Semifinal"
        } else if gameState.series == 1 {
            return "Division Final"
        } else if gameState.series == 2 {
            return "Conference Final"
        } else if gameState.series == 3 {
            return "Playoff Cup Final"
        } else {
            fatalError("Series out of range")
        }
    }
    
    var seriesPrefix: String {
        if gameState.series == 0 {
            return "\(gameState.playerTeam.division.rawValue.capitalized)"
        } else if gameState.series == 1 {
            return "\(gameState.playerTeam.division.rawValue.capitalized)"
        } else if gameState.series == 2 {
            return "\(gameState.playerTeam.conference.rawValue.capitalized)"
        } else if gameState.series == 3 {
            return ""
        } else {
            fatalError("Series out of range")
        }
    }
    
    var seriesScore: String {
        var tempString = ""
        
        if gameState.playerSeriesScore > gameState.aiSeriesScore {
            tempString = gameState.playerSeriesScore == 4 ? "\(gameState.playerTeam.teamName) Win \(gameState.playerSeriesScore) - \(gameState.aiSeriesScore)" : "\(gameState.playerTeam.teamName) Lead \(gameState.playerSeriesScore) - \(gameState.aiSeriesScore)"
        } else if gameState.playerSeriesScore < gameState.aiSeriesScore {
            tempString = gameState.aiSeriesScore == 4 ? "\(gameState.aiTeam.teamName) Win \(gameState.playerSeriesScore) - \(gameState.aiSeriesScore)" : "\(gameState.aiTeam.teamName) Lead \(gameState.playerSeriesScore) - \(gameState.aiSeriesScore)"
        } else {
            tempString = "Series Tied \(gameState.playerSeriesScore) - \(gameState.aiSeriesScore)"
        }
        
        return tempString
    }
    
    var body: some View {
        GeometryReader { geo in
            let widthAdjustment = geo.size.width * (150 / 200)
            ZStack {
                RadialGradient(gradient: Gradient(stops: [
                    .init(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 0.05),
                    .init(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 0.15),
                    .init(color: .black, location: 0.60),
                ]), center: .bottom, startRadius: 60, endRadius: 900)
                .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        
//                        HStack(spacing: 3) {
//                            Text("\(seriesPrefix)")
//                                .font(.subheadline)
//                                .foregroundStyle(gameState.highlightColor)
//                            Text("\(seriesName)")
//                                .font(.subheadline)
//                                .foregroundStyle(gameState.highlightColor)
//                        }
                        Text("PLAYOFF CUP")
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(gameState.highlightColor)
                        
                        Text("\(seriesScore)")
                            .font(.caption)
                            .italic()
                            .foregroundStyle(.white)
                        Text("GAME \(gameState.game)")
                            .font(.headline)
                            .foregroundStyle(gameState.highlightColor)
                        
                        ZStack {
                            
                            gameState.playerTeam.firstColor
                                .frame(width: 180, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            if gameState.enableRinkView {
                                VStack {
                                    
                                    HStack {
                                        Text(gameState.playerTeam.mascot)
                                            .font(.system(size: 50))
                                        Text("\(gameState.playerGameScore)")
                                            .font(.largeTitle.weight(.black))
                                    }
                                    Text(gameState.playerTeam.teamLocation)
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(.black)
                                    Text(gameState.playerTeam.teamName)
                                        .font(.subheadline.weight(.heavy))
                                        .foregroundStyle(.black)
                                }
                                
                                .frame(width: 120, height: 100)
                                .padding(10)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .rotation3DEffect(.degrees(spinAnimation), axis: (x: 0, y: 1, z: 0))
                            }
                            
                            if !gameState.enableRinkView {
                                Button {
                                    showTeamSelection = true
                                } label: {
                                    Text("SELECT YOUR \nTEAM")
                                        .font(.title2.weight(.heavy))
                                        .frame(width: 120, height: 100)
                                        .padding(10)
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .rotation3DEffect(.degrees(selectTeamAnimation), axis: (x: 0, y: 1, z: 0))
                                }
                            }
                        }
                        .onAppear(perform: selectTeamSpin)
                        .onChange(of: gameState.playerTeamIndex) { newValue in
                            spin()
                        }
                        .onChange(of: gameState.series) { newValue in
                            if newValue == 0 {
                                resetEverything()
                            }
                        }
                        
                        if gameState.enableRinkView {
                            ZStack {
                                gameState.aiTeam.firstColor
                                    .frame(width: 180, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                VStack {
                                    if gameState.enableRinkView {
                                        HStack {
                                            Text(gameState.aiTeam.mascot)
                                                .font(.system(size: 50))
                                            Text("\(gameState.aiGameScore)")
                                                .font(.largeTitle.weight(.black))
                                        }
                                        Text(gameState.aiTeam.teamLocation)
                                            .font(.subheadline.weight(.semibold))
                                            .foregroundStyle(.black)
                                        Text(gameState.aiTeam.teamName)
                                            .font(.subheadline.weight(.heavy))
                                            .foregroundStyle(.black)
                                    }
                                }
                                .frame(width: 120, height: 100)
                                .padding(10)
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 3) {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                resetEverything()
                            } label: {
                                Text("🏆 ")
                                    .font(.title.weight(.heavy))
                                    .foregroundStyle(gameState.highlightColor)
                            }
                            HStack(spacing: 3) {
                                Text("\(seriesPrefix) ")
                                    .font(.title.weight(.heavy))
                                    .foregroundStyle(gameState.highlightColor)
                                Text("\(seriesName)")
                                    .font(.title.weight(.heavy))
                                    .foregroundStyle(gameState.highlightColor)
                            }
//                            Text("PLAYOFF CUP")
//                                .font(.title.weight(.heavy))
//                                .foregroundStyle(gameState.highlightColor)
                            Spacer()
                            Button {
                                showSettings = true
                            } label: {
                                gameState.highlightColor
                                    .frame(width: 20, height: 20)
                                    .background(gameState.highlightColor)
                                    .clipShape(Circle())
                                    .padding(4)
                                    .background(.black)
                                    .clipShape(Circle())
                            }
                        }
                        
                        ActionButtonView(gameState: gameState, schedule: schedule)
                            .frame(width: widthAdjustment)
                        
                        MeterView(gameState: gameState)
                            
                    }
                }
                .preferredColorScheme(.light)
                
                VStack {
                    Spacer()
                    HStack {
                        Text("App by Mark Bourgeois")
                            .font(.caption2)
                            .offset(x: 35, y: 16)
                        Spacer()
                    }
                }
            }
        }
        
        .sheet(isPresented: $gameState.showGameSummary) {
            GameSummaryView(gameState: gameState, schedule: schedule)
                .preferredColorScheme(.light)
        }
        
        .sheet(isPresented: $gameState.showSeriesSummary) {
            SeriesSummaryView(gameState: gameState, schedule: schedule)
                .preferredColorScheme(.light)
        }
        
        .sheet(isPresented: $showTeamSelection) {
            TeamSelectionView(gameState: gameState, schedule: schedule)
                .preferredColorScheme(.light)
        }
        
        .sheet(isPresented: $showSettings) {
            SettingsView(gameState: gameState)
                .preferredColorScheme(.light)
        }
        
        .onAppear {
            loadTeams()
        }
    }
    
    func spin() {
        withAnimation(.easeInOut(duration: 1).delay(0.5)) {
            spinAnimation += 360
        }
    }
    
    func selectTeamSpin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            withAnimation(.easeInOut(duration: 1).delay(1.0).repeatForever(autoreverses: false)) {
                selectTeamAnimation += 360
            }
        }
    }
    
    func resetEverything() {
        gameState.highlightColor = Color(red: 255 / 255, green: 255 / 255, blue: 25 / 255)
        
        gameState.allTeams.removeAll()
        gameState.playerTeam = Team()
        gameState.aiTeam = Team()
        
        
        gameState.playerTeamIndex = 0
        gameState.aiTeamIndex = 0
        
        gameState.period = 1
        gameState.game = 1
        gameState.series = 0
        
        gameState.playerGameScore = 0
        gameState.aiGameScore = 0
        gameState.playerFinalGameScore = 0
        gameState.aiFinalGameScore = 0
        gameState.playerSeriesScore = 0
        gameState.aiSeriesScore = 0
        
        gameState.skatersLeft = 5
        gameState.hitMeter = 0
        gameState.powerPlays = 0
        
        gameState.enableHitMeter = false
        gameState.enablePowerPlay = false
        
        gameState.showSeriesSummary = false
        gameState.showGameSummary = false
        gameState.enableRinkView = false
        gameState.zamboni = false
        
        gameState.momentum = 50
        
        showTeamSelection = false
        
        spinAnimation = 0.0
        selectTeamAnimation = 0.0
        
//        zamboni()
        loadTeams()
        selectTeamSpin()
    }
    
    func loadTeams() {
        gameState.allTeams.removeAll()
        
        
        let nun = Team(teamID: "NUN", teamName: "Octopuses", teamLocation: "Nunavut",
                       country: "🇨🇦", mascot: "🐙", division: .north, conference: .rival,
//                       firstColor: Color(red: 0.639, green: 0.149, blue: 0.294))
                       firstColor: Color(red: 230 / 255, green: 25 / 255, blue: 75 / 255))
        self.gameState.allTeams.append(nun)
        
        let mon = Team(teamID: "MON", teamName: "Blizzards", teamLocation: "Montana",
                       country: "🇺🇸", mascot: "❄️", division: .north, conference: .rival,
//                       firstColor: Color(red: 0.012, green: 0.843, blue: 0.988))
                       firstColor: Color(red: 70 / 255, green: 240 / 255, blue: 240 / 255))
        self.gameState.allTeams.append(mon)
        
        let akx = Team(teamID: "AKX", teamName: "Unicorns", teamLocation: "Alaska",
                       country: "🇺🇸", mascot: "🦄", division: .north, conference: .rival,
//                       firstColor: Color(red: 0.580, green: 0.098, blue: 0.557))
                       firstColor: Color(red: 240 / 255, green: 50 / 255, blue: 230 / 255))
        self.gameState.allTeams.append(akx)
        
        let sas = Team(teamID: "SAS", teamName: "Dragons", teamLocation: "Saskatchewan",
                       country: "🇨🇦", mascot: "🐲", division: .north, conference: .rival,
//                       firstColor: Color(red: 0.019, green: 0.290, blue: 0.024))
                       firstColor: Color(red: 60 / 255, green: 180 / 255, blue: 75 / 255))
        self.gameState.allTeams.append(sas)
        
        
        let nbx = Team(teamID: "NBX", teamName: "Pufferfish", teamLocation: "New Brunswick",
                       country: "🇨🇦", mascot: "🐡", division: .east, conference: .rival,
//                       firstColor: Color(red: 0.588, green: 0.443, blue: 0.102))
                       firstColor: Color(red: 240 / 255, green: 200 / 255, blue: 165 / 255))
        self.gameState.allTeams.append(nbx)
        
        let vir = Team(teamID: "VIR", teamName: "Bats", teamLocation: "Virginia",
                       country: "🇺🇸", mascot: "🦇", division: .east, conference: .rival,
//                       firstColor: Color(red: 0.200, green: 0.169, blue: 0.094))
                       firstColor: Color(red: 170 / 255, green: 110 / 255, blue: 40 / 255))
        self.gameState.allTeams.append(vir)
        
        let mne = Team(teamID: "MNE", teamName: "Piranha", teamLocation: "Maine",
                       country: "🇺🇸", mascot: "🐟", division: .east, conference: .rival,
//                       firstColor: Color(red: 0.098, green: 0.204, blue: 0.580))
                       firstColor: Color(red: 220 / 255, green: 190 / 255, blue: 255 / 255))
        self.gameState.allTeams.append(mne)
        
        let geo = Team(teamID: "GEO", teamName: "Alligators", teamLocation: "Georgia",
                       country: "🇺🇸", mascot: "🐊", division: .east, conference: .rival,
//                       firstColor: Color(red: 0.290, green: 0.529, blue: 0.212))
                       firstColor: Color(red: 170 / 255, green: 255 / 255, blue: 195 / 255))
        self.gameState.allTeams.append(geo)
        
        
        let okl = Team(teamID: "OKL", teamName: "Earthquake", teamLocation: "Oklahoma",
                       country: "🇺🇸", mascot: "🌎", division: .south, conference: .valor,
//                       firstColor: Color(red: 0.239, green: 0.451, blue: 0.949))
                       firstColor: Color(red: 0 / 255, green: 130 / 255, blue: 200 / 255))
        self.gameState.allTeams.append(okl)
        
        let nmx = Team(teamID: "NMX", teamName: "Scorpions", teamLocation: "New Mexico",
                       country: "🇺🇸", mascot: "🦂", division: .south, conference: .valor,
//                       firstColor: Color(red: 0.659, green: 0.286, blue: 0.250))
                       firstColor: Color(red: 128 / 255, green: 128 / 255, blue: 0 / 255))
        self.gameState.allTeams.append(nmx)
        
        let ala = Team(teamID: "ALA", teamName: "Gorillas", teamLocation: "Alabama",
                       country: "🇺🇸", mascot: "🦍", division: .south, conference: .valor,
//                       firstColor: Color(red: 0.988, green: 0.890, blue: 0.000))
                       firstColor: Color(red: 255 / 255, green: 255 / 255, blue: 25 / 255))
        self.gameState.allTeams.append(ala)
        
        let lou = Team(teamID: "LOU", teamName: "Snakes", teamLocation: "Louisiana",
                       country: "🇺🇸", mascot: "🐍", division: .south, conference: .valor,
//                       firstColor: Color(red: 0.000, green: 1.000, blue: 0.000))
                       firstColor: Color(red: 210 / 255, green: 245 / 255, blue: 60 / 255))
        self.gameState.allTeams.append(lou)
        
        
        let ore = Team(teamID: "ORE", teamName: "Supernovas", teamLocation: "Oregon",
                       country: "🇺🇸", mascot: "💥", division: .west, conference: .valor,
//                       firstColor: Color(red: 0.545, green: 0.180, blue: 0.788))
                       firstColor: Color(red: 145 / 255, green: 30 / 255, blue: 180 / 255))
        self.gameState.allTeams.append(ore)
        
        let yuk = Team(teamID: "YUK", teamName: "Foxes", teamLocation: "Yukon",
                       country: "🇨🇦", mascot: "🦊", division: .west, conference: .valor,
//                       firstColor: Color(red: 0.871, green: 0.196, blue: 0.027))
                       firstColor: Color(red: 245 / 255, green: 130 / 255, blue: 48 / 255))
        self.gameState.allTeams.append(yuk)
        
        let ida = Team(teamID: "IDA", teamName: "Boars", teamLocation: "Idaho",
                       country: "🇺🇸", mascot: "🐗", division: .west, conference: .valor,
//                       firstColor: Color(red: 0.098, green: 0.008, blue: 0.302))
                       firstColor: Color(red: 255 / 255, green: 250 / 255, blue: 200 / 255))
        self.gameState.allTeams.append(ida)
        
        let uta = Team(teamID: "UTA", teamName: "Raccoons", teamLocation: "Utah",
                       country: "🇺🇸", mascot: "🦝", division: .west, conference: .valor,
//                       firstColor: Color(red: 0.067, green: 0.322, blue: 0.302))
                       firstColor: Color(red: 30 / 255, green: 158 / 255, blue: 158 / 255))
        self.gameState.allTeams.append(uta)
        
        
        gameState.playerTeamIndex = Int.random(in: 0..<gameState.allTeams.count)
        gameState.playerTeam = gameState.allTeams[gameState.playerTeamIndex]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .previewInterfaceOrientation(.landscapeRight)
    }
}
