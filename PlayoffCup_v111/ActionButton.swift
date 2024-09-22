//
//  ActionButton.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/24/23.
//

import Foundation

struct ActionButton {
    var action = ""
    var actionOpacity = 0.0
    var puckOpacity = 1.0
    var scaleAmount = 1.0
    var flipAnimation = 0.0
    var disabled = false
    var blockedShot = false
    
    func displayAction(action: String) -> String {
        switch action {
        case "Penalty":
            return "⛔️"
        case "Goal":
            return "🥅"
        case "Breakaway":
            return "👍"
        case "Giveaway":
            return "👎"
        case "Opponent Goal":
            return "😡"
        case "Hit":
            return "🗯️"
        case "Extra Skater":
            return "⛸️"
        case "Power Play Collected":
            return "⚡️"
        case "Penalty Shot":
            return "🏒"
        case "Offside":
            return "⚠️"
        case "Icing":
            return "🧊"
        default:
            return ""
        }
    }
    
    func displayBlockedShot() -> String {
        return "🚫"
    }
}
