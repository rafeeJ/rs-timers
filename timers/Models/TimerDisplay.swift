//
//  TimerDisplay.swift
//  timers
//
//  Created by Rafee Jenkins on 27/03/2025.
//

import Foundation

struct TimerDisplay: Codable, Identifiable {
    let id: UUID
    let name: String
    let duration: TimeInterval
    let finishTime: Date
}

extension TimerDisplay {
    func toLocalNotification() -> LocalNotification {
        LocalNotification(
            identifier: id.uuidString,
            title: "Timer: \(name)",
            body: "Time's up!",
            timeInterval: timeRemaining,
            repeats: false
        )
    }

    var timeRemaining: TimeInterval {
        max(finishTime.timeIntervalSinceNow, 1)
    }
}
