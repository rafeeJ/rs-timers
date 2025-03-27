//
//  timersApp.swift
//  timers
//
//  Created by Rafee Jenkins on 26/03/2025.
//

import SwiftUI
import SwiftData

@main
struct timersApp: App {
    @StateObject private var timerManager: TimerManager

    init() {
        let lnManager = LocalNotificationManager()
        let dataManager = DataManager()
        _timerManager = StateObject(wrappedValue: TimerManager(dataManager: dataManager, notificationManager: lnManager))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerManager)
        }
    }
}
