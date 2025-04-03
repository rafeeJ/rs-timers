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
                            ActiveTimerListItem(timer: timer)
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    timerManager.deleteTimer(timer)
                                }
                            }
                        }
                    }
                    .overlay(Group {
                        if timerManager.timers.isEmpty {
                            VStack {
                                Text("No Timers")
                                    .font(.custom("Jersey10-Regular", size: 32))
                                    .foregroundColor(Color(red: 216/255, green: 179/255, blue: 110/255))
                                Text("Tap the + button to add a timer!")
                                    .font(.custom("Jersey10-Regular", size: 24))
                                    .foregroundColor(Color(red: 216/255, green: 179/255, blue: 110/255))
                            }
                        }
                    })
                    .listStyle(PlainListStyle())
                }
                .background(Color(red: 36/255, green: 31/255, blue: 25/255))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Timers")
                            .font(.custom("Jersey10-Regular", size: 32))
                            .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingTimerListView = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Button(role: .destructive) {
                                timerManager.clearAllTimers()
                            } label: {
                                Label("Clear All Timers", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                        }
                    }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showingTimerListView) {
            TimerListView()
        }.onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(red: 76/255, green: 65/255, blue: 47/255, alpha: 1.0)
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
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
                ZStack {
                    Color(red: 94/255, green: 84/255, blue: 66/255)

                    RoundedRectangle(cornerRadius: 0)
                        .strokeBorder(Color.black, lineWidth: 4)
                        .padding(2)

                    RoundedRectangle(cornerRadius: 0)
                        .strokeBorder(Color(red: 160/255, green: 140/255, blue: 100/255), lineWidth: 1)
                        .padding(6)
                }
            )
            .fixedSize()
    }
}


#Preview {
    ContentView()
        .environmentObject(TimerManager(dataManager: DataManager(), notificationManager: LocalNotificationManager()))
}
