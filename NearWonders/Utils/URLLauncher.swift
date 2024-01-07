//
//  URLLauncher.swift
//  NearWonders
//
//  Created by Jay Thakur on 31/12/23.
//

import Foundation
import MapKit.MKTypes

class URLLauncher {
    static func mapDirections(for coordinates: CLLocationCoordinate2D, completionHandler completion: ((Bool) -> Void)? = nil) throws {
        if let url = mapDirectionsUrl(for: coordinates) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: completion)
            } else {
                throw GenericError.canOpenUrlFailed
            }
        } else {
            throw GenericError.failedToParseUrl
        }
    }
}
