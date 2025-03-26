//
//  ContentView.swift
//  timers
//
//  Created by Rafee Jenkins on 26/03/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var lnManager: LocalNotificationManager
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        NavigationView {
            VStack {
                if lnManager.isGranted {
                    GroupBox("Schedule") {
                        Button("Interval Notification") {
                            Task {
                                let localNotification = LocalNotification(identifier: UUID().uuidString,
                                                                          title: "Some Title",
                                                                          body: "some body",
                                                                          timeInterval: 10,
                                                                          repeats: false)
                                await lnManager.schedule(localNotification: localNotification)
                            }
                        }
                        .buttonStyle(.bordered)
                        Button("Calendar Notification") {
                            
                        }
                        .buttonStyle(.bordered)
                    }
                    .frame(width: 300)
                    List {
                        ForEach(lnManager.pendingRequests, id: \.identifier) { request in
                            VStack(alignment: .leading) {
                                Text(request.content.title)
                                HStack {
                                    Text(request.identifier)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    lnManager.removeRequest(withIdentifier: request.identifier)
                                }
                            }
                        }
                    }
                } else {
                    Button("Enable Notifications") {
                        lnManager.openSettings()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Local Notifications")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        lnManager.clearRequests()
                    } label: {
                        Image(systemName: "clear.fill")
                            .imageScale(.large)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            try? await lnManager.requestAuthorization()
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                Task {
                    await lnManager.getCurrentSettings()
                    await lnManager.getPendingRequests()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalNotificationManager())
}
