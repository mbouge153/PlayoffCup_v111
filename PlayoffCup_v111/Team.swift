//
//  Team.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/14/23.
//

import Foundation
import SwiftUI


enum Division: String {
    case north, east, south, west
}

enum Conference: String {
    case rival, valor
}

struct Team {
    var teamID: String
    var teamName: String
    var teamLocation: String

    var country: String
    var mascot: String
    
    var division: Division
    var conference: Conference
    
    var firstColor: Color
    
    var advance: Bool = true
    var gameWins: Int = 0
    var seriesWins = [Int]()
    
    init(teamID: String, teamName: String, teamLocation: String, country: String, mascot: String, division: Division, conference: Conference, firstColor: Color) {
        self.teamID = teamID
        self.teamName = teamName
        self.teamLocation = teamLocation
        self.country = country
        self.mascot = mascot
        self.division = division
        self.conference = conference
        self.firstColor = firstColor
    }
    
    init() {
        teamID = "NUN"
        teamName = "Octopuses"
        teamLocation = "Nunavut"
        country = "🇨🇦"
        mascot = "🐙"
        division = .north
        conference = .rival
        firstColor = Color(red: 230 / 255, green: 25 / 255, blue: 75 / 255)
    }
}
