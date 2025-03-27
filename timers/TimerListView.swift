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
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }
                
                ForEach(timerCategories, id: \.name) { category in
                    Section(header: Text(category.name)) {
                        ForEach(category.timers) { timer in
                            TimerButton(timer: timer)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
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
        HStack {
            VStack(alignment: .leading) {
                Text(timer.name)
                    .font(.custom("Jersey10-Regular", size: 24))
                    .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))

                Text(formattedDuration)
                    .padding(.horizontal, 10)
                    .font(.custom("Jersey10-Regular", size: 20))
                    .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                    .background(
                        Color(red: 33/255, green: 30/255, blue: 23/255)
                    )
                    .border(Color(red: 19/255, green: 16/255, blue: 8/255), width: 2)
            }
            .padding(10)
            
            Spacer()
            
            Button(action: {
                let finishTime = Date().addingTimeInterval(TimeInterval(timer.duration * 60))
                let newTimer = TimerDisplay(
                    id: UUID(),
                    name: timer.name,
                    duration: TimeInterval(timer.duration * 60),
                    finishTime: finishTime
                )
                timerManager.addTimer(newTimer)
                dismiss()
            }) {
                Text("START")
                    .font(.custom("Jersey10-Regular", size: 24))
                    .padding(5)
                    .background(Color(red: 91/255, green: 120/255, blue: 58/255))
                    .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 22/255, green: 19/255, blue: 14/255), lineWidth: 2))
            }
        }
        .padding(.horizontal, 10)
        .background(Color(red: 39/255, green: 29/255, blue: 18/255))
        .overlay(
            RoundedRectangle(cornerRadius: 2)
            .stroke(Color(red: 89/255, green: 71/255, blue: 49/255), lineWidth: 2)
        )
        .padding(2)
    }
}

#Preview {
    TimerListView()
}
