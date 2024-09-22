//
//  ActionButtonView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/24/23.
//

import SwiftUI

struct PuckButton: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(Circle())
        }
    }
}

extension View {
    func puckButtonStyle() -> some View {
        modifier(PuckButton())
    }
}

struct ActionButtonView: View {
    @ObservedObject var gameState: GameState
    @ObservedObject var schedule: Schedule
    
    @State var actionButtons = [ActionButton]()
    @State private var assignActions = [String]()
    @State private var allActions = ["Penalty", "Penalty", "Opponent Goal", "Goal", "Goal", "Goal", "Breakaway", "Breakaway", "Breakaway", "Giveaway", "Giveaway", "Giveaway", "Hit", "Hit", "Opponent Goal", "Extra Skater", "Power Play Collected", "Penalty Shot"]
    
//    @State private var period: Int = 1
    @State private var overtime: Bool = false
    @State private var endGame: Bool = false
    
    @State private var currentButton: String = ""
    @State private var currentButtonColor = Color.black
    
    @State private var animationAmount = 1.0
//    @State private var cardFlipAnimation = 0.0
    @State private var hideAnimation = 0.0
    @State private var actionAnimation = 0.0
    @State private var showAction = false
    
    @State private var showBlockedShot = false
    
    var dangerZone: Bool {
        if gameState.period == 2 && gameState.aiGameScore > gameState.playerGameScore + 2 {
            return true
        } else if gameState.period >= 3 && gameState.aiGameScore > gameState.playerGameScore + 1 {
            return true
        } else if gameState.momentum <= 25 {
            return true
        } else {
            return false
        }
    }
    
    var easyStreet: Bool {
        if gameState.period == 2 && gameState.playerGameScore > gameState.aiGameScore + 2 {
            return true
        } else if gameState.period >= 3 && gameState.playerGameScore > gameState.aiGameScore + 1 {
            return true
        } else if gameState.momentum >= 85 {
            return true
        } else {
            return false
        }
    }
    
    var helpPlayerLevel1: Bool {
        if gameState.series == 1 && gameState.aiSeriesScore > gameState.playerSeriesScore + 2 {
            return true
        } else if gameState.series == 2 && gameState.aiSeriesScore > gameState.playerSeriesScore + 1 {
            return true
        } else if gameState.series == 3 && gameState.aiSeriesScore > gameState.playerSeriesScore {
            return true
        } else {
            return false
        }
    }
    
    var helpPlayerLevel2: Bool {
        if gameState.series == 1 && gameState.aiSeriesScore > gameState.playerSeriesScore + 2 {
            return true
        } else if gameState.series == 2 && gameState.aiSeriesScore > gameState.playerSeriesScore + 1 {
            return true
        } else if gameState.series == 3 && gameState.aiSeriesScore > gameState.playerSeriesScore {
            return true
        } else {
            return false
        }
    }
    
    var hinderPlayerLevel1: Bool {
        if gameState.series == 1 && gameState.playerSeriesScore > gameState.aiSeriesScore + 2 {
            return true
        } else if gameState.series == 2 && gameState.playerSeriesScore > gameState.aiSeriesScore + 1 {
            return true
        } else if gameState.series == 3 && gameState.playerSeriesScore > gameState.aiSeriesScore {
            return true
        } else {
            return false
        }
    }
    
    var hinderPlayerLevel2: Bool {
        if gameState.series == 1 && gameState.playerSeriesScore > gameState.aiSeriesScore + 2 {
            return true
        } else if gameState.series == 2 && gameState.playerSeriesScore > gameState.aiSeriesScore + 1 {
            return true
        } else if gameState.series == 3 && gameState.playerSeriesScore > gameState.aiSeriesScore {
            return true
        } else {
            return false
        }
    }
    
    var rinkCorner: Double = 16/200
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geo in
            let widthAdjustment = geo.size.width
            
            ZStack {
                RinkView(gameState: gameState)
                    .frame(width: widthAdjustment, height: widthAdjustment * (85 / 200))
                    .padding(.horizontal, widthAdjustment * 4 / 200)
                
                RoundedRectangle(cornerRadius: widthAdjustment * rinkCorner)
                    .fill(.white)
                    .frame(width: widthAdjustment - 65, height: widthAdjustment * (70 / 200))
                    .opacity(0.6)
                    .offset(y: 0)

                
                if gameState.enableRinkView {
                    
                    LazyVGrid(columns: layout) {
                        ForEach(0..<actionButtons.count, id: \.self) { button in
                            ZStack {
                                Text(actionButtons[button].displayAction(action: actionButtons[button].action))
                                    .font(.system(size: 32))
                                    .opacity(actionButtons[button].actionOpacity)
                                    .animation(.easeInOut(duration: 0.5), value: actionButtons[button].actionOpacity)
                                    .frame(maxWidth: .infinity)
                                
//                                if showBlockedShot {
//                                    Text(actionButtons[button].displayBlockedShot())
//                                        .font(.system(size: 32))
//                                        .opacity(actionButtons[button].actionOpacity)
//                                        .animation(.easeInOut(duration: 0.5), value: actionButtons[button].actionOpacity)
//                                        .frame(maxWidth: .infinity)
//                                }
                                
                                Button {
                                    actionButtons[button].disabled = true
                                    if gameState.skatersLeft > 0 {
                                        if dangerZone {
                                            actionButtons[button].action = help()
                                        } else if easyStreet {
                                            actionButtons[button].action = hinder()
                                        } else if helpPlayerLevel1 {
                                            actionButtons[button].action = helpLevel2()
                                        } else if hinderPlayerLevel1 {
                                            actionButtons[button].action = hinderLevel2()
                                        }
                                        resolveAction(action: actionButtons[button].action)
                                        
                                        actionButtons[button].actionOpacity = 1.0
                                        actionButtons[button].puckOpacity = 0.0
                                        actionButtons[button].scaleAmount = 4.0
                                        withAnimation(.easeInOut(duration: 0.4).delay(0.4)) {
                                            actionAnimation += 1.0
                                        }
                                        withAnimation(.easeInOut(duration: 0.3).delay(0.9)) {
                                            actionAnimation -= 1.0
                                        }
                                    } else if gameState.period >= 3 {
                                        if gameState.playerGameScore == gameState.aiGameScore {
                                            overtime = true
                                            nextPeriod()
                                        } else {
                                            overtime = false
                                            endGame = true
                                            animationAmount = 1.0
                                            currentButton = "Game Summary"
                                        }
                                    } else {
                                        nextPeriod()
                                    }
                                } label: {
                                    Color(red: 0.2, green: 0.2, blue: 0.2)
                                        .puckButtonStyle()
                                        .scaleEffect(actionButtons[button].scaleAmount)
                                        .opacity(actionButtons[button].puckOpacity)
                                        .animation(.easeInOut(duration: 0.5), value: actionButtons[button].puckOpacity)
                                        .rotation3DEffect(.degrees(actionButtons[button].flipAnimation), axis: (x: 0, y: 1, z: 0))
                                        .frame(maxWidth: .infinity)
                                }
                                .disabled(actionButtons[button].disabled)
                            }
                        }
                        .padding(0.5)
                    }
                    .frame(width: widthAdjustment - 70)
                    .offset(y: 0)
                }
                
                if gameState.enableRinkView {
                
                RoundedRectangle(cornerRadius: 55)
                    .strokeBorder(.black, lineWidth: 10)
                    .frame(width: 430, height: 150)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 55))
                    .opacity(2 - animationAmount)
                
                
                    Button {
                        if endGame {
                            if gameState.playerGameScore > gameState.aiGameScore {
                                gameState.playerSeriesScore += 1
                            } else {
                                gameState.aiSeriesScore += 1
                            }
                            gameState.playerFinalGameScore = gameState.playerGameScore
                            gameState.aiFinalGameScore = gameState.aiGameScore
                            schedule.advanceGames(gameState: gameState)
                            if gameState.playerSeriesScore == 4 || gameState.aiSeriesScore == 4 {
                                gameState.showSeriesSummary = true
                            } else {
                                gameState.showGameSummary = true
                            }
                            startGame()
                        } else {
                            animationAmount += 1.0
                            withAnimation(.easeInOut(duration: 1).delay(0.5)) {
                                for i in 0..<actionButtons.count {
                                    actionButtons[i].flipAnimation += 360.0
                                }
                            }
                            withAnimation(.easeInOut(duration: 1).delay(2)) {
                                hideAnimation = 1.0
                            }
                        }
                        
                    } label: {
                        VStack(spacing: 10) {
//                            Spacer()
                            if overtime {
                                Text("OVERTIME!")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(.black)
                                    .textCase(.uppercase)
                            }
                            
                            
                            Text(endGame ? "Game Final" : "START\nPERIOD \(gameState.period)")
                                .frame(width: 300)
                                .background(.white)
                                .font(.largeTitle.weight(.black))
                                .foregroundStyle(.black)
                                .italic()
                                .textCase(.uppercase)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                            
                            
                            if endGame {
                                Text(gameState.playerGameScore > gameState.aiGameScore ? "\(gameState.playerTeam.teamName) Win!" : "\(gameState.aiTeam.teamName) Win")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(.black)
                                    .textCase(.uppercase)
                            }
//                            Spacer()
                        }
                    }
                    .frame(width: 430, height: 150)
//                    .background(.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 55))
                    .padding(10)
                    .opacity(2 - animationAmount)
                    .disabled(!gameState.enableRinkView)
                }
                
                RoundedRectangle(cornerRadius: 55)
                    .strokeBorder(currentButtonColor, lineWidth: 10)
                    .frame(width: 430, height: 150)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 55))
                    .opacity(actionAnimation)
                
                Text("\(currentButton)")
                    .frame(width: 430, height: 150)
//                    .background(.white)
                    .font(.largeTitle.weight(.black))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(currentButtonColor)
                    .italic()
                    .textCase(.uppercase)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding(5)
//                    .background(currentButtonColor)
//                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .opacity(actionAnimation)
                
//                if showBlockedShot {
//                    Text("🚫 BLOCKED! 🚫")
//                        .frame(width: 430, height: 150)
    //                    .background(.white)
//                        .font(.largeTitle.weight(.black))
//                        .multilineTextAlignment(.center)
//                        .foregroundStyle(currentButtonColor)
//                        .italic()
//                        .textCase(.uppercase)
//                        .clipShape(RoundedRectangle(cornerRadius: 40))
//                        .padding(5)
    //                    .background(currentButtonColor)
    //                    .clipShape(RoundedRectangle(cornerRadius: 50))
//                        .opacity(actionAnimation)
//                        .offset(y: 20)
//                }
            }
        }
        .onAppear {
            startGame()
        }
        
        .onChange(of: gameState.enablePowerPlay) { newValue in
            if gameState.enablePowerPlay == true {
                resolveAction(action: "Power Play")
                gameState.enablePowerPlay = false
                withAnimation(.easeInOut(duration: 0.5).delay(0.4)) {
                    actionAnimation += 1.0
                }
                withAnimation(.easeInOut(duration: 0.5).delay(1.2)) {
                    actionAnimation -= 1.0
                }
            }
        }
        .onChange(of: showBlockedShot) { newValue in
            if newValue == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showBlockedShot = false
                }
            }
        }
    }
    
    func zamboni() {
        for i in 0..<actionButtons.count {
            withAnimation(.easeInOut(duration: 1).delay(0.5)) {
                actionButtons[i].flipAnimation += 360
            }
            actionButtons[i].actionOpacity = 0.0
            actionButtons[i].puckOpacity = 1.0
            actionButtons[i].scaleAmount = 1.0
            actionButtons[i].disabled = false
            
        }
    }
    
    func loadActions() {
        actionButtons.removeAll()
        
        if gameState.series == 0 {
            allActions = ["Goal", "Goal", "Goal", "Opponent Goal", "Opponent Goal", "Breakaway", "Breakaway", "Breakaway", "Breakaway", "Giveaway", "Giveaway", "Giveaway", "Penalty", "Penalty", "Penalty", "Extra Skater", "Power Play Collected", "Penalty Shot", "Offside", "Offside", "Offside", "Icing", "Icing", "Icing", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit"]
//            allActions = ["Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal"]
        } else if gameState.series == 1 {
            allActions = ["Goal", "Goal", "Goal", "Opponent Goal", "Opponent Goal", "Breakaway", "Breakaway", "Breakaway", "Giveaway", "Giveaway", "Giveaway", "Penalty", "Penalty", "Penalty", "Extra Skater", "Power Play Collected", "Penalty Shot", "Offside", "Offside", "Offside", "Icing", "Icing", "Icing", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit"]
            
//            allActions = ["Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal"]
        } else if gameState.series == 2 {
            allActions = ["Goal", "Goal", "Opponent Goal", "Opponent Goal", "Breakaway", "Breakaway", "Breakaway", "Giveaway", "Giveaway", "Giveaway", "Penalty", "Penalty", "Penalty", "Extra Skater", "Power Play Collected", "Penalty Shot", "Offside", "Offside", "Offside", "Icing", "Icing", "Icing", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit"]
            
//            allActions = ["Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal"]
        } else if gameState.series == 3 {
            allActions = ["Goal", "Goal", "Opponent Goal", "Opponent Goal", "Breakaway", "Breakaway", "Giveaway", "Giveaway", "Giveaway", "Penalty", "Penalty", "Penalty", "Extra Skater", "Power Play Collected", "Penalty Shot", "Offside", "Offside", "Offside", "Icing", "Icing", "Icing", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit"]
            
//            allActions = ["Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal", "Goal"]
        }
        
        
        assignActions = allActions.shuffled()
        var tempIndex: Int = 0
        
        for _ in 0..<assignActions.count {
            tempIndex = Int.random(in: 0..<assignActions.count)
            var actionButtonTemp = ActionButton()
            actionButtonTemp.action = assignActions[tempIndex]
            actionButtons.append(actionButtonTemp)
            assignActions.remove(at: tempIndex)
        }
    }
    
    func help() -> String {
        let tempActions = ["Hit", "Hit", "Breakaway", "Penalty Shot"]
        let tempIndex = Int.random(in: 0..<tempActions.count)
        return tempActions[tempIndex]
    }
    
    func helpLevel1() -> String {
        let tempActions = ["Goal", "Breakaway", "Breakaway", "Penalty Shot", "Penalty Shot", "Extra Skater", "Power Play Collected", "Hit", "Hit", "Hit", "Hit", "Giveaway", "Penalty", "Offside", "Icing"]
        let tempIndex = Int.random(in: 0..<tempActions.count)
        return tempActions[tempIndex]
    }
    
    func helpLevel2() -> String {
        let tempActions = ["Goal", "Goal", "Breakaway", "Breakaway", "Breakaway", "Penalty Shot", "Penalty Shot", "Penalty Shot", "Extra Skater", "Power Play Collected", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Hit", "Penalty", "Offside", "Icing"]
        let tempIndex = Int.random(in: 0..<tempActions.count)
        return tempActions[tempIndex]
    }
    
    func hinder() -> String {
        let tempActions = ["Offside", "Icing", "Giveaway", "Giveaway"]
        let tempIndex = Int.random(in: 0..<tempActions.count)
        return tempActions[tempIndex]
    }
    
    func hinderLevel1() -> String {
        let tempActions = ["Opponent Goal", "Giveaway", "Giveaway", "Giveaway", "Giveaway", "Penalty", "Penalty", "Offside", "Offside", "Icing", "Icing", "Breakaway", "Hit", "Hit", "Hit"]
        let tempIndex = Int.random(in: 0..<tempActions.count)
        return tempActions[tempIndex]
    }
    
    func hinderLevel2() -> String {
        let tempActions = ["Opponent Goal", "Opponent Goal", "Giveaway", "Giveaway", "Giveaway", "Giveaway", "Giveaway", "Giveaway", "Penalty", "Penalty", "Offside", "Offside", "Offside", "Offside", "Icing", "Icing", "Icing", "Icing", "Extra Skater", "Hit", "Hit"]
        let tempIndex = Int.random(in: 0..<tempActions.count)
        return tempActions[tempIndex]
    }
    
    func resolveAction(action: String) {
        switch action {
        case "Penalty":
            gameState.skatersLeft -= 2
            currentButton = action
            currentButtonColor = .red
            
            addMomentum(-3)
            
//            if gameState.playerInARow > 0 {
//                gameState.playerInARow = 0
//                gameState.aiInARow = 1
//                if gameState.momentum > 27 {
//                    gameState.momentum -= 3
//                } else {
//                    gameState.momentum = 25
//                }
//            } else if gameState.aiInARow == 1 {
//                gameState.aiInARow += 1
//                if gameState.momentum > 30 {
//                    gameState.momentum -= 6
//                } else {
//                    gameState.momentum = 25
//                }
//            } else {
//                gameState.aiInARow += 1
//                if gameState.momentum > 33 {
//                    gameState.momentum -= 9
//                } else {
//                    gameState.momentum = 25
//                }
//            }

        case "Goal":
            gameState.skatersLeft -= 1
            gameState.playerGameScore += 1
            currentButton = action
            currentButtonColor = .green
            
            addMomentum(4)
            
//            if gameState.aiInARow > 0 {
//                gameState.aiInARow = 0
//                gameState.playerInARow = 1
//                if gameState.momentum < 72 {
//                    gameState.momentum += 4
//                } else {
//                    gameState.momentum = 75
//                }
//            } else if gameState.playerInARow == 1 {
//                gameState.playerInARow += 1
//                if gameState.momentum < 68 {
//                    gameState.momentum += 8
//                } else {
//                    gameState.momentum = 75
//                }
//            } else {
//                gameState.playerInARow += 1
//                if gameState.momentum < 64 {
//                    gameState.momentum += 12
//                } else {
//                    gameState.momentum = 75
//                }
//            }
            
        case "Breakaway":
            gameState.skatersLeft -= 1
            let temp = Int.random(in: 1...100)
            if temp <= gameState.momentum {
                gameState.playerGameScore += 1
                currentButton = action
                currentButtonColor = .green
                
                addMomentum(5)
                
//                if gameState.aiInARow > 0 {
//                    gameState.aiInARow = 0
//                    gameState.playerInARow = 1
//                    if gameState.momentum < 71 {
//                        gameState.momentum += 5
//                    } else {
//                        gameState.momentum = 75
//                    }
//                } else if gameState.playerInARow == 1 {
//                    gameState.playerInARow += 1
//                    if gameState.momentum < 66 {
//                        gameState.momentum += 10
//                    } else {
//                        gameState.momentum = 75
//                    }
//                } else {
//                    gameState.playerInARow += 1
//                    if gameState.momentum < 61 {
//                        gameState.momentum += 15
//                    } else {
//                        gameState.momentum = 75
//                    }
//                }
            } else {
                showBlockedShot = true
                currentButton = action + "\n🚫 BLOCKED! 🚫"
                currentButtonColor = .black
                
                addMomentum(2)
                
//                if gameState.playerInARow > 0 {
//                    gameState.playerInARow = 0
//                    gameState.aiInARow = 1
//                    
//                } else {
//                    gameState.aiInARow += 1
//                }
//                if gameState.momentum < 74 {
//                    gameState.momentum += 2
//                } else {
//                    gameState.momentum = 75
//                }
            }
            
        case "Giveaway":
            gameState.skatersLeft -= 1
            let temp = Int.random(in: 1...100)
            if gameState.enableHitMeter == true {
                showBlockedShot = true
                currentButton = action + "\n🚫 BLOCKED! 🚫"
                currentButtonColor = .green
                gameState.enableHitMeter = false
                
                addMomentum(-2)
                
//                if gameState.aiInARow > 0 {
//                    gameState.aiInARow = 0
//                    gameState.playerInARow = 1
//                    
//                } else {
//                    gameState.playerInARow += 1
//                }
//                if gameState.momentum > 26 {
//                    gameState.momentum -= 2
//                } else {
//                    gameState.momentum = 25
//                }
                
            } else if temp > gameState.momentum {
                gameState.aiGameScore += 1
                currentButton = action
                currentButtonColor = .red
                
                addMomentum(-5)
                
//                if gameState.playerInARow > 0 {
//                    gameState.playerInARow = 0
//                    gameState.aiInARow = 1
//                    if gameState.momentum > 29 {
//                        gameState.momentum -= 5
//                    } else {
//                        gameState.momentum = 25
//                    }
//                } else if gameState.aiInARow == 1 {
//                    gameState.aiInARow += 1
//                    if gameState.momentum > 34 {
//                        gameState.momentum -= 10
//                    } else {
//                        gameState.momentum = 25
//                    }
//                } else {
//                    gameState.aiInARow += 1
//                    if gameState.momentum > 39 {
//                        gameState.momentum -= 15
//                    } else {
//                        gameState.momentum = 25
//                    }
//                }

            } else {
                showBlockedShot = true
                currentButton = action + "\n🚫 BLOCKED! 🚫"
                currentButtonColor = .black
                
                addMomentum(-2)
                
//                if gameState.aiInARow > 0 {
//                    gameState.aiInARow = 0
//                    gameState.playerInARow = 1
//                    
//                } else {
//                    gameState.playerInARow += 1
//                }
//                if gameState.momentum > 26 {
//                    gameState.momentum -= 2
//                } else {
//                    gameState.momentum = 25
//                }
            }
            
        case "Opponent Goal":
            gameState.skatersLeft -= 1
            if gameState.enableHitMeter == true {
                showBlockedShot = true
                currentButton = action + "\n🚫 BLOCKED! 🚫"
                currentButtonColor = .green
                gameState.enableHitMeter = false
                
                addMomentum(-2)
                
//                if gameState.aiInARow > 0 {
//                    gameState.aiInARow = 0
//                    gameState.playerInARow = 1
//                    
//                } else {
//                    gameState.playerInARow += 1
//                }
//                if gameState.momentum > 26 {
//                    gameState.momentum -= 2
//                } else {
//                    gameState.momentum = 25
//                }
                
            } else {
                gameState.aiGameScore += 1
                currentButton = action
                currentButtonColor = .red
                
                addMomentum(-4)
                
//                if gameState.playerInARow > 0 {
//                    gameState.playerInARow = 0
//                    gameState.aiInARow = 1
//                    if gameState.momentum > 28 {
//                        gameState.momentum -= 4
//                    } else {
//                        gameState.momentum = 25
//                    }
//                } else if gameState.aiInARow == 1 {
//                    gameState.aiInARow += 1
//                    if gameState.momentum > 32 {
//                        gameState.momentum -= 8
//                    } else {
//                        gameState.momentum = 25
//                    }
//                } else {
//                    gameState.aiInARow += 1
//                    if gameState.momentum > 36 {
//                        gameState.momentum -= 12
//                    } else {
//                        gameState.momentum = 25
//                    }
//                }
            }
        case "Hit":
            if gameState.hitMeter < 24 {
                gameState.hitMeter += 1
            }
            currentButton = action
            currentButtonColor = .blue
            
            addMomentum(1)
            
//            if gameState.aiInARow > 0 {
//                gameState.aiInARow = 0
//                gameState.playerInARow = 1
//                if gameState.momentum < 75 {
//                    gameState.momentum += 1
//                } else {
//                    gameState.momentum = 75
//                }
//            } else if gameState.playerInARow == 1 {
//                gameState.playerInARow += 1
//                if gameState.momentum < 74 {
//                    gameState.momentum += 2
//                } else {
//                    gameState.momentum = 75
//                }
//            } else {
//                gameState.playerInARow += 1
//                if gameState.momentum < 73 {
//                    gameState.momentum += 3
//                } else {
//                    gameState.momentum = 75
//                }
//            }
            
        case "Extra Skater":
            gameState.skatersLeft += 1
            currentButton = action
            currentButtonColor = .black
            
            addMomentum(2)
            
//            if gameState.aiInARow > 0 {
//                gameState.aiInARow = 0
//                gameState.playerInARow = 1
//                if gameState.momentum < 74 {
//                    gameState.momentum += 2
//                } else {
//                    gameState.momentum = 75
//                }
//            } else if gameState.playerInARow == 1 {
//                gameState.playerInARow += 1
//                if gameState.momentum < 72 {
//                    gameState.momentum += 4
//                } else {
//                    gameState.momentum = 75
//                }
//            } else {
//                gameState.playerInARow += 1
//                if gameState.momentum < 70 {
//                    gameState.momentum += 6
//                } else {
//                    gameState.momentum = 75
//                }
//            }
            
        case "Power Play Collected":
            gameState.skatersLeft -= 1
            gameState.powerPlays += 1
            currentButton = action
            currentButtonColor = .purple
            
//            if gameState.aiInARow > 0 {
//                gameState.aiInARow = 0
//                gameState.playerInARow = 1
//                if gameState.momentum < 74 {
//                    gameState.momentum += 2
//                } else {
//                    gameState.momentum = 75
//                }
//            } else if gameState.playerInARow == 1 {
//                gameState.playerInARow += 1
//                if gameState.momentum < 72 {
//                    gameState.momentum += 4
//                } else {
//                    gameState.momentum = 75
//                }
//            } else {
//                gameState.playerInARow += 1
//                if gameState.momentum < 70 {
//                    gameState.momentum += 6
//                } else {
//                    gameState.momentum = 75
//                }
//            }

        case "Power Play":
            gameState.powerPlays -= 1
            gameState.skatersLeft += 1
            gameState.playerGameScore += 1
            currentButton = action
            currentButtonColor = .green
            
            addMomentum(4)
            
//            if gameState.aiInARow > 0 {
//                gameState.aiInARow = 0
//                gameState.playerInARow = 1
//                if gameState.momentum < 72 {
//                    gameState.momentum += 4
//                } else {
//                    gameState.momentum = 75
//                }
//            } else if gameState.playerInARow == 1 {
//                gameState.playerInARow += 1
//                if gameState.momentum < 68 {
//                    gameState.momentum += 8
//                } else {
//                    gameState.momentum = 75
//                }
//            } else {
//                gameState.playerInARow += 1
//                if gameState.momentum < 64 {
//                    gameState.momentum += 12
//                } else {
//                    gameState.momentum = 75
//                }
//            }

        case "Penalty Shot":
            gameState.skatersLeft -= 1
            let temp = Int.random(in: 1...100)
            if temp <= gameState.momentum {
                gameState.playerGameScore += 1
                currentButton = action
                currentButtonColor = .green
                
                addMomentum(5)
                
//                if gameState.aiInARow > 0 {
//                    gameState.aiInARow = 0
//                    gameState.playerInARow = 1
//                    if gameState.momentum < 71 {
//                        gameState.momentum += 5
//                    } else {
//                        gameState.momentum = 75
//                    }
//                } else if gameState.playerInARow == 1 {
//                    gameState.playerInARow += 1
//                    if gameState.momentum < 66 {
//                        gameState.momentum += 10
//                    } else {
//                        gameState.momentum = 75
//                    }
//                } else {
//                    gameState.playerInARow += 1
//                    if gameState.momentum < 61 {
//                        gameState.momentum += 15
//                    } else {
//                        gameState.momentum = 75
//                    }
//                }
            } else {
                showBlockedShot = true
                currentButton = action + "\n🚫 BLOCKED! 🚫"
                currentButtonColor = .black
                
                addMomentum(2)
                
//                if gameState.playerInARow > 0 {
//                    gameState.playerInARow = 0
//                    gameState.aiInARow = 1
//                    
//                } else {
//                    gameState.aiInARow += 1
//                }
//                if gameState.momentum < 74 {
//                    gameState.momentum += 2
//                } else {
//                    gameState.momentum = 75
//                }
            }

        case "Offside":
            gameState.skatersLeft -= 1
            currentButton = action
            currentButtonColor = .black
            
            addMomentum(-2)
            
//            if gameState.playerInARow > 0 {
//                gameState.playerInARow = 0
//                gameState.aiInARow = 1
//                if gameState.momentum > 26 {
//                    gameState.momentum -= 2
//                } else {
//                    gameState.momentum = 25
//                }
//            } else if gameState.aiInARow == 1 {
//                gameState.aiInARow += 1
//                if gameState.momentum > 28 {
//                    gameState.momentum -= 4
//                } else {
//                    gameState.momentum = 25
//                }
//            } else {
//                gameState.aiInARow += 1
//                if gameState.momentum > 30 {
//                    gameState.momentum -= 6
//                } else {
//                    gameState.momentum = 25
//                }
//            }

        case "Icing":
            gameState.skatersLeft -= 1
            currentButton = action
            currentButtonColor = .black
            
            addMomentum(-1)
            
//            if gameState.playerInARow > 0 {
//                gameState.playerInARow = 0
//                gameState.aiInARow = 1
//                if gameState.momentum > 25 {
//                    gameState.momentum -= 1
//                } else {
//                    gameState.momentum = 25
//                }
//            } else if gameState.aiInARow == 1 {
//                gameState.aiInARow += 1
//                if gameState.momentum > 26 {
//                    gameState.momentum -= 2
//                } else {
//                    gameState.momentum = 25
//                }
//            } else {
//                gameState.aiInARow += 1
//                if gameState.momentum > 27 {
//                    gameState.momentum -= 3
//                } else {
//                    gameState.momentum = 25
//                }
//            }
            
        default:
            fatalError("Action Not Defined")
        }
    }
    
    func addMomentum(_ amount: Int) {
        let momentumStart = 20
        let momentumEnd = 80
        
        let limit1 = 40
        let limit2 = 60
        
        if amount > 0 {
            if gameState.momentum >= limit2 {
                if gameState.momentum + amount > momentumEnd {
                    gameState.momentum = momentumEnd
                } else {
                    gameState.momentum += amount
                }
            } else if gameState.momentum >= limit1 {
                gameState.momentum += (amount * 2)
            } else {
                gameState.momentum += (amount * 3)
            }
        } else {
            if gameState.momentum <= limit1 {
                if gameState.momentum + amount < momentumStart {
                    gameState.momentum = momentumStart
                } else {
                    gameState.momentum += amount
                }
            } else if gameState.momentum <= limit2 {
                gameState.momentum += (amount * 2)
            } else {
                gameState.momentum += (amount * 3)
            }
        }
    }
    
    func nextPeriod() {
        gameState.period += 1
        gameState.skatersLeft = 5
        gameState.playerFinalGameScore = 0
        gameState.aiFinalGameScore = 0
        
        currentButton = ""
        
        withAnimation(.easeInOut(duration: 2)) {
            animationAmount = 1.0
        }
        hideAnimation = 0.0
        withAnimation(.easeInOut(duration: 1).delay(0.5)) {
            for i in 0..<actionButtons.count {
                actionButtons[i].flipAnimation = 0.0
            }
        }
        
        zamboni()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.40) {
            loadActions()
        }
    }
    
    func startGame() {
        overtime = false
        endGame = false
        
        gameState.period = 1
        gameState.skatersLeft = 5
        gameState.playerGameScore = 0
        gameState.aiGameScore = 0
        
        currentButton = ""
        
        animationAmount = 1.0
        hideAnimation = 0.0
        for i in 0..<actionButtons.count {
            actionButtons[i].flipAnimation = 0.0
        }
        
        zamboni()
        loadActions()
    }
    
}

#Preview {
    ActionButtonView(gameState: GameState(), schedule: Schedule())
}
