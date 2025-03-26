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
    @StateObject var lnManager = LocalNotificationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lnManager)
        }
    }
}
