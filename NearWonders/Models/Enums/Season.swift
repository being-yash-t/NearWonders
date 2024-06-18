//
//  Season.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import Foundation

enum Season: String, Codable, Identifiable, CaseIterable {
    case Summer = "summer"
    case Winter = "winter"
    case Spring = "spring"
    case Autumn = "autumn"
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .Summer:
            return "Summer"
        case .Winter:
            return "Winter"
        case .Spring:
            return "Spring"
        case .Autumn:
            return "Autumn"
        }
    }
    
    var icon: Icon {
        switch self {
        case .Summer:
            return Icon.summer
        case .Winter:
            return Icon.winter
        case .Spring:
            return Icon.spring
        case .Autumn:
            return Icon.autumn
        }
    }
    
    var rgbColor: [Double] {
        switch self {
        case .Summer:
            return [253, 216, 53]
        case .Winter:
            return [153, 204, 255]
        case .Spring:
            return [144, 238, 144]
        case .Autumn:
            return [184, 115, 51]
        }
    }
    
}

