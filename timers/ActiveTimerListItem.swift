//
//  ActiveTimerListItem.swift
//  timers
//
//  Created by Rafee Jenkins on 28/03/2025.
//

import SwiftUI

struct ActiveTimerListItem: View {
    var timer: TimerDisplay
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(timer.finishTime < Date() ?
                      Color(red: 91/255, green: 120/255, blue: 58/255) :
                      Color(red: 76/255, green: 65/255, blue: 47/255))
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
            
            HStack {
                Text(timer.name)
                    .font(.custom("Jersey10-Regular", size: 32))
                    .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
                Spacer()
                Text(timer.finishTime, style: .relative)
                    .font(.custom("Jersey10-Regular", size: 32))
                    .foregroundColor(Color(red: 231/255, green: 196/255, blue: 132/255))
            }.padding(10)
        }
        .listRowInsets(EdgeInsets())
    }
}


#Preview {
    List {
        ActiveTimerListItem(timer: TimerDisplay(id: UUID(), name: "Next Week", duration: 50, finishTime: Date(timeInterval: 600, since: Date())))
        ActiveTimerListItem(timer: TimerDisplay(id: UUID(), name: "5 Mins ago", duration: 50, finishTime: Date(timeInterval: -600, since: Date())))
    }.listStyle(PlainListStyle())
}
