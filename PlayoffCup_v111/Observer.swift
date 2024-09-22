//
//  Observer.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 10/4/23.
//

import SwiftUI

class Observer: ObservableObject {
    @Published var enteredForeground = true
    
    init() {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    @objc func willEnterForeground() {
        enteredForeground.toggle()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
