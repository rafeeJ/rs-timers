//  TimerListView.swift
//  timers
//
//  Created by Rafee Jenkins on 26/03/2025.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var timerManager: TimerManager

    var timerCategories: [TimerCategory] {
        timers.map { key, value in
            TimerCategory(name: key, timers: value)
        }
    }

    var body: some View {
        List {
            ForEach(timerCategories, id: \.name) { category in
                Section(header: Text(category.name)) {
                    ForEach(category.timers) { timer in
                        TimerButton(timer: timer)
                    }
                }
            }
        }
    }
}

struct TimerButton: View {
    @EnvironmentObject var timerManager: TimerManager
    var timer: TimerItem

    var body: some View {
        Button {
            let finishTime = Date().addingTimeInterval(TimeInterval(timer.duration * 60))
            let newTimer = TimerDisplay(
                id: UUID(),
                name: timer.name,
                duration: TimeInterval(timer.duration * 60),
                finishTime: finishTime
            )
            timerManager.addTimer(newTimer)
        } label: {
            VStack(alignment: .leading) {
                Text(timer.name)
                Text("\(timer.duration) Minutes")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    TimerListView()
}
