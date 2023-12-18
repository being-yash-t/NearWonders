//
//  Acitivity.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import Foundation

struct Activity: Equatable, Identifiable, Hashable {
    var id: String { name }
    let name: String
    let icon: String?
    let rgbColor: [Double]
    
    static func ==(lhs: Activity, rhs: Activity) -> Bool {
        lhs.name == rhs.name && lhs.icon == rhs.icon
        && lhs.rgbColor == rhs.rgbColor
    }
}
