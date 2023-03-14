//
//  CLLocationCoordinate2D + Equatable.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 13/03/2023.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.latitude == rhs.latitude
        && lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
        
    }
}
