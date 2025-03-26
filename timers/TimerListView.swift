//  TimerListView.swift
//  timers
//
//  Created by Rafee Jenkins on 26/03/2025.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var lnManager: LocalNotificationManager

    let timerPresets = [
        Preset(identifier: UUID().uuidString, title: "Short Timer", body: "This is a short timer", timeInterval: 5, repeats: false),
        Preset(identifier: UUID().uuidString, title: "Medium Timer", body: "This is a medium timer", timeInterval: 10, repeats: false),
        Preset(identifier: UUID().uuidString, title: "Long Timer", body: "This is a long timer", timeInterval: 30, repeats: false)
    ]

    var body: some View {
        List(timerPresets) { preset in
            Button {
                Task {
                    let localNotification = LocalNotification(identifier: preset.identifier,
                                                              title: preset.title,
                                                              body: preset.body,
                                                              timeInterval: preset.timeInterval,
                                                              repeats: preset.repeats)
                    await lnManager.schedule(localNotification: localNotification)
                }
            } label: {
                VStack(alignment: .leading) {
                    Text(preset.title)
                    Text("\(Int(preset.timeInterval)) seconds")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    TimerListView()
}
