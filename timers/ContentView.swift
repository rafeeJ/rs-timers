//
//  ContentView.swift
//  timers
//
//  Created by Rafee Jenkins on 26/03/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var timerManager: TimerManager
    @Environment(\.scenePhase) var scenePhase
    @State private var showingTimerListView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(timerManager.timers) { timer in
                        VStack(alignment: .leading) {
                            Text(timer.name)
                            Text(timer.finishTime, style: .relative)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                timerManager.deleteTimer(timer)
                            }
                        }
                    }
                }

                Spacer()
                Button {
                    showingTimerListView = true
                } label: {
                    Label("Add Timer", systemImage: "plus.circle.fill")
                        .font(.system(.body, design: .rounded))
                }
            }
            .navigationTitle("Timers")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        timerManager.clearAllTimers()
                    } label: {
                        Image(systemName: "clear.fill")
                            .imageScale(.large)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showingTimerListView) {
            TimerListView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerManager(dataManager: DataManager(), notificationManager: LocalNotificationManager()))
}
