//
//  Season.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import Foundation

enum Season: String, Identifiable, CaseIterable {
    case Summer
    case Winter
    case Spring
    case Autumn
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case Season.Summer:
            return "Summer"
        case Season.Winter:
            return "Winter"
        case Season.Spring:
            return "Spring"
        case Season.Autumn:
            return "Autumn"
        }
    }
    
    var icon: String {
        switch self {
        case Season.Summer:
            return "sun.max"
        case Season.Winter:
            return "snowflake"
        case Season.Spring:
            return "wind"
        case Season.Autumn:
            return "cloud.sun"
        }
    }
    
    var rgbColor: [Double] {
        switch self {
        case Season.Summer:
            return [253, 216, 53]
        case Season.Winter:
            return [153, 204, 255]
        case Season.Spring:
            return [144, 238, 144]
        case Season.Autumn:
            return [184, 115, 51]
        }
    }
    
}

