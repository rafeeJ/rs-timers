//
//  ActiveTimerListItem.swift
//  timers
//
//  Created by Rafee Jenkins on 28/03/2025.
//

import SwiftUI

struct ActiveTimerListItem: View {
    var timer: TimerDisplay
    @State private var currentTime = Date()
    let timerUpdate = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(timer.finishTime < currentTime ?
                      Color(red: 91/255, green: 120/255, blue: 58/255) :
                      Color(red: 76/255, green: 65/255, blue: 47/255))
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
            
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
                
                Text(timer.name)
                    .font(.custom("Jersey10-Regular", size: 32))
                    .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                Spacer()
                if timer.finishTime < currentTime {
                    Text("Done!")
                        .font(.custom("Jersey10-Regular", size: 32))
                        .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                } else {
                    Text(timer.finishTime, style: .relative)
                        .font(.custom("Jersey10-Regular", size: 32))
                        .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                }
            }.padding(10)
        }
        .listRowInsets(EdgeInsets())
        .onReceive(timerUpdate) { _ in
            currentTime = Date()
        }
    }
}


#Preview {
    List {
        ActiveTimerListItem(timer: TimerDisplay(id: UUID(), name: "Next Week", duration: 50, imageUrl: "https://oldschool.runescape.wiki/images/Redwood_logs.png?2e2e3", finishTime: Date(timeInterval: 600, since: Date())))
        ActiveTimerListItem(timer: TimerDisplay(id: UUID(), name: "5 Mins ago", duration: 50, imageUrl: "https://oldschool.runescape.wiki/images/Redwood_logs.png?2e2e3", finishTime: Date(timeInterval: -600, since: Date())))
    }.listStyle(PlainListStyle())
}
