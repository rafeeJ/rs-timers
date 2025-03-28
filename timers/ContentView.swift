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
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 80/255, green: 60/255, blue: 40/255),
                        Color(red: 50/255, green: 35/255, blue: 20/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 120/255, green: 100/255, blue: 80/255).opacity(0.4),
                        Color.clear
                    ]),
                    center: .bottomLeading,
                    startRadius: 5,
                    endRadius: 400
                )
                .blendMode(.overlay)
                .edgesIgnoringSafeArea(.all)

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
                    .listStyle(PlainListStyle())
                    
                    Spacer()
                    AddTimerButton()
                        .onTapGesture {
                            showingTimerListView = true
                        }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Timers")
                            .font(.custom("Jersey10-Regular", size: 32))
                            .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            timerManager.clearAllTimers()
                        } label: {
                            Image(systemName: "clear.fill")
                                .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                        }
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
            appearance.backgroundColor = UIColor(Color.gray.opacity(0.2))
            
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
