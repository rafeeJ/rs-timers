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
        timers
    }
    
    let fontColor = Color(red: 255/255, green: 152/255, blue: 31/255)
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TimerListViewItem(timer: TimerItem(id: 1, name: "1 Minute", duration: 1, imageUrl: ""))
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                } header: {
                    TimerListHeader(title: "Test")
                }
                ForEach(timerCategories) { category in
                    Section {
                        ForEach(category.timers) { timer in
                            TimerListViewItem(timer: timer)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                    } header: {
                        TimerListHeader(title: category.name)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(red: 36/255, green: 31/255, blue: 25/255))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add Timer")
                        .font(.custom("Jersey10-Regular", size: 32))
                        .foregroundColor(fontColor)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                    }
                }
            }
        }.onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(red: 76/255, green: 65/255, blue: 47/255, alpha: 1.0)
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct TimerListHeader: View {
    var title: String
    
    let fontColor = Color(red: 255/255, green: 152/255, blue: 31/255)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 76/255, green: 65/255, blue: 47/255))
                .frame(height: .infinity)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
            Text(title)
                .font(.custom("Jersey10-Regular", size: 24))
                .foregroundStyle(fontColor)
        }.listRowInsets(EdgeInsets())
    }
}

#Preview {
    TimerListView()
}
