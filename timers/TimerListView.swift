//  TimerListView.swift
//  timers
//
//  Created by Rafee Jenkins on 26/03/2025.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var timerManager: TimerManager
    @Environment(\.dismiss) private var dismiss
    
    var timerCategories: [TimerCategory] {
        timers.map { key, value in
            TimerCategory(name: key, timers: value)
        }
    }
    
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("Quick Timers")) {
                    TimerButton(timer: TimerItem(id: UUID(), name: "1 Minute", duration: 1))
                }
                
                ForEach(timerCategories, id: \.name) { category in
                    Section(header: Text(category.name)) {
                        ForEach(category.timers) { timer in
                            TimerButton(timer: timer)
                        }
                    }
                }
            }
            .navigationTitle("Add Timer")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct TimerButton: View {
    @EnvironmentObject var timerManager: TimerManager
    @Environment(\.dismiss) private var dismiss
    var timer: TimerItem
    
    private var formattedDuration: String {
        if timer.duration >= 60 {
            let hours = Int(timer.duration) / 60
            let minutes = Int(timer.duration) % 60
            if minutes == 0 {
                return "\(hours) \(hours == 1 ? "Hour" : "Hours")"
            } else {
                return "\(hours) \(hours == 1 ? "Hour" : "Hours") \(minutes) \(minutes == 1 ? "Minute" : "Minutes")"
            }
        } else {
            return "\(Int(timer.duration)) \(Int(timer.duration) == 1 ? "Minute" : "Minutes")"
        }
    }
    
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
            dismiss()
        } label: {
            VStack(alignment: .leading) {
                Text(timer.name)
                Text(formattedDuration)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    TimerListView()
}
