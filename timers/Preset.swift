//
// Created for LocalNotifications
// by Stewart Lynch on 2022-05-23
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation

struct Preset: Identifiable {
    var id = UUID()
    var identifier: String
    var title: String
    var body: String
    var timeInterval: Double
    var repeats: Bool
}
