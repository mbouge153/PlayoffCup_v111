//
//  GameState.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/14/23.
//

import Foundation
import SwiftUI

class GameState: ObservableObject {
    @Published var highlightColor = Color(red: 255 / 255, green: 255 / 255, blue: 25 / 255)
    
    @Published var allTeams = [Team]()
    @Published var playerTeam = Team()
    @Published var aiTeam = Team()
    
    @Published var playerTeamIndex: Int = 0
    @Published var aiTeamIndex: Int = 0
    
    @Published var period = 1
    @Published var game = 1
    @Published var series = 0
    
    @Published var playerGameScore = 0
    @Published var aiGameScore = 0
    @Published var playerFinalGameScore = 0
    @Published var aiFinalGameScore = 0
    @Published var playerSeriesScore = 0
    @Published var aiSeriesScore = 0
    
    @Published var skatersLeft = 5
    @Published var hitMeter = 0
    @Published var powerPlays = 0
    
    @Published var enableHitMeter = false
    @Published var enablePowerPlay = false
    @Published var momentum = 50
    
    @Published var showSeriesSummary = false
    @Published var showGameSummary = false
    @Published var enableRinkView = false
    @Published var zamboni = false
    
    @Published var playerInARow = 0
    @Published var aiInARow = 0
}
