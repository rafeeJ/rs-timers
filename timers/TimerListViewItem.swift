//
//  TimerListViewItem.swift
//  timers
//
//  Created by Rafee Jenkins on 29/03/2025.
//

import SwiftUI

struct TimerListViewItem: View {
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
    
    let fontColor = Color(red: 255/255, green: 152/255, blue: 31/255)
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: timer.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 30, height: 30)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(timer.name)
                    .padding(.horizontal, 10)
                    .font(.custom("Jersey10-Regular", size: 24))
                    .foregroundColor(fontColor)
                    .background(
                        Color(red: 41/255, green: 26/255, blue: 21/255)
                    )
                    .border(Color(red: 19/255, green: 16/255, blue: 8/255), width: 2)
                
                Text(formattedDuration)
                    .padding(.horizontal, 10)
                    .font(.custom("Jersey10-Regular", size: 20))
                    .foregroundColor(fontColor)
                    .background(
                        Color(red: 41/255, green: 26/255, blue: 21/255)
                    )
                    .border(Color(red: 19/255, green: 16/255, blue: 8/255), width: 2)
            }
            .padding(5)
            
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
                    .foregroundColor(fontColor)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(red: 22/255, green: 19/255, blue: 14/255), lineWidth: 2))
            }
        }
        .padding(.horizontal, 10)
        .background(
            Color(red: 84/255, green: 76/255, blue: 65/255)
        )
        .overlay(
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 2))
        )
    }
}

#Preview {
    List {
        TimerListViewItem(timer: TimerItem(id: 1,name: "Test", duration: 10, imageUrl: "https://oldschool.runescape.wiki/images/Oak_tree.png"))
    }
    .listStyle(PlainListStyle())
    .navigationBarTitleDisplayMode(.inline)
}
