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
                AddTimerButton()
                    .onTapGesture {
                        showingTimerListView = true
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

struct AddTimerButton: View {
    var body: some View {
        Text("ADD TIMER")
            .font(.custom("Jersey10-Regular", size: 32))
            .foregroundColor(Color(red: 216/255, green: 179/255, blue: 110/255))
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(red: 94/255, green: 84/255, blue: 66/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
            )
    }
}


#Preview {
    ContentView()
        .environmentObject(TimerManager(dataManager: DataManager(), notificationManager: LocalNotificationManager()))
}
