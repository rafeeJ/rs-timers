//
// Created for LocalNotifications
// by Stewart Lynch on 2022-05-23
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation

struct TimerCategory: Decodable {
    let name: String
    let timers: [TimerItem]
}

struct TimerItem: Identifiable, Decodable {
    let id: UUID
    let name: String
    let duration: Int
}
