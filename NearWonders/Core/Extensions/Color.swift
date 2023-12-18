//
//  Color.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/12/23.
//

import SwiftUI

extension Color {
    init(rgb: [Double]) {
        let red = rgb[0] / 255.0
        let green = rgb[1] / 255.0
        let blue = rgb[2] / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
