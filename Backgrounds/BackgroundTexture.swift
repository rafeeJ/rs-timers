//
//  BackgroundTexture.swift
//  timers
//
//  Created by Rafee Jenkins on 27/03/2025.
//

import SwiftUI

extension LinearGradient {
    static let blueClearGradient = LinearGradient(colors: [.blue, .clear],
                                             startPoint: .bottom,
                                             endPoint: .top)
}

extension RadialGradient {
    static let radialYellowGradient = RadialGradient(colors: [.yellow, .clear],
                                                 center: .topLeading,
                                                 startRadius: 100,
                                                 endRadius: 400)

    static let radialRedGradient = RadialGradient(colors: [.red, .clear],
                                               center: .topTrailing,
                                               startRadius: 100,
                                               endRadius: 400)
}
