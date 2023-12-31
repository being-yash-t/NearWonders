//
//  URLs.swift
//  NearWonders
//
//  Created by Jay Thakur on 31/12/23.
//

import Foundation
import MapKit.MKTypes

func mapDirectionsUrl(for coordinates: CLLocationCoordinate2D) -> URL? {
    URL(string: "maps://?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)")
}
