//
//  ModelData.swift
//  youtube-display
//
//  Created by Rafee Jenkins on 16/03/2025.
//

import Foundation
import SwiftUI
import WidgetKit

@MainActor
@Observable
class DataManager {
    class Storage {
        @AppStorage("timers", store: UserDefaults(suiteName: "group.com.relli.timers"))
        var timerData: Data?
    }

    private let storage = Storage()

    var timers: [TimerDisplay] {
        didSet { saveTimers() }
    }

    init() {
        if let data = storage.timerData {
            timers = (try? JSONDecoder().decode([TimerDisplay].self, from: data)) ?? []
        } else {
            timers = []
        }
    }

    private func saveTimers() {
        if let encodedData = try? JSONEncoder().encode(timers) {
            storage.timerData = encodedData
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
