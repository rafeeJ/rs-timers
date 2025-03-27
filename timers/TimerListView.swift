//  TimerListView.swift
//  timers
//
//  Created by Rafee Jenkins on 26/03/2025.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var lnManager: LocalNotificationManager

    var body: some View {
        let timerCategories: [TimerCategory] = timers.map { key, value in
            TimerCategory(name: key, timers: value)
        }

        return List {
            ForEach(timerCategories, id: \.name) { category in
                Section(header: Text(category.name)) {
                    ForEach(category.timers) { timer in
                        Button {
                            Task {
                                let localNotification = LocalNotification(
                                    identifier: timer.id.uuidString,
                                    title: timer.name,
                                    body: "",
                                    timeInterval: TimeInterval(timer.duration * 60),
                                    repeats: false
                                )
                                await lnManager.schedule(localNotification: localNotification)
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                Text(timer.name)
                                Text("\(timer.duration) seconds")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TimerListView()
}
