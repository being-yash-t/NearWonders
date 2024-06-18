//
//  Acitivity.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import Foundation


enum Activity: String, Codable, Identifiable, CaseIterable {
    case Trek = "trek"
    case Camp = "camp"
    case BikeTrail = "bike-trail"
    case OffRoadTrail = "off-road-trail"
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .Trek: return "Trekking"
        case .Camp: return "Camping"
        case .BikeTrail: return "Biking Trail"
        case .OffRoadTrail : return "OffRoading Trail"
        }
    }
    
    var iconData: Icon {
        switch self {
        case .Trek: return Icon.trek
        case .Camp: return Icon.camp
        case .BikeTrail: return Icon.bike
        case .OffRoadTrail : return Icon.motorbike
        }
    }
    
    var rgbColor: [Double] {
        switch self {
        case .Trek:
            return [253, 216, 53]
        case .Camp:
            return [153, 204, 255]
        case .BikeTrail:
            return [144, 238, 144]
        case .OffRoadTrail:
            return [184, 115, 51]
        }
    }
    
}



