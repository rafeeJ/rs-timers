//
//  TimerManager.swift
//  timers
//
//  Created by Rafee Jenkins on 27/03/2025.
//
import Foundation
import SwiftUI

@MainActor
class TimerManager: ObservableObject {
    private let dataManager: DataManager
    private let notificationManager: LocalNotificationManager

    init(dataManager: DataManager, notificationManager: LocalNotificationManager) {
        self.dataManager = dataManager
        self.notificationManager = notificationManager
    }

    var timers: [TimerDisplay] {
        dataManager.timers
    }

    func addTimer(_ timer: TimerDisplay) {
        dataManager.timers.append(timer)
        Task {
            await notificationManager.schedule(localNotification: timer.toLocalNotification())
        }
    }

    func deleteTimer(_ timer: TimerDisplay) {
        dataManager.timers.removeAll { $0.id == timer.id }
        notificationManager.removeRequest(withIdentifier: timer.id.uuidString)
    }
    
    func clearAllTimers() {
        for timer in dataManager.timers {
            notificationManager.removeRequest(withIdentifier: timer.id.uuidString)
        }
        dataManager.timers.removeAll()
    }
}
