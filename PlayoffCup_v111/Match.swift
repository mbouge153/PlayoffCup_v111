//
//  Match.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/4/23.
//

import Foundation
import SwiftUI

class Match: ObservableObject {
    @Published var series: Series
    
    var continueSeries: Bool {
        if series.team1SeriesScore == 4 || series.team2SeriesScore == 4 {
            return false
        } else {
            return true
        }
    }
    
    init(teams: [Team]) {
        self.series = Series(teams: teams, playerSeries: false)
    }
    
    init(teams: [Team], playerMatch: Bool) {
        self.series = Series(teams: teams, playerSeries: playerMatch)
    }
    
    func displayMatch() -> some View {
        return ZStack {
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    Text(series.games.last?.displayGameNumber() ?? "GAME 0")
                        .font(.footnote)
                    Spacer()
                    Text(series.displaySeries())
                        .font(.subheadline)
                        .italic()
                    Spacer()
                }
                series.games.last?.display(team1: series.teams[0], team2: series.teams[1], continueSeries: continueSeries)
//                    .offset(y: -20)
            }
        }
    }
    
    func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            withAnimation(.easeInOut(duration: 1).delay(1.0).repeatForever(autoreverses: false)) {
                self.series.games.last?.spinWinner()
            }
        }
    }
}
