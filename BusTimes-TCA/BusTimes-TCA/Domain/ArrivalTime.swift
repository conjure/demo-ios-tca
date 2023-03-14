//
//  ArrivalTime.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 14/03/2023.
//

import Foundation

struct ArrivalTime: Codable, Hashable {
    var id: String
    
    var naptanId: String
    var timeToStation: Int
    var stationName: String
    var lineName: String
    var destinationName: String
    
    var timeInMinutes: String {
        if timeToStation < 60 {
            return "Due"
        }
        return "\(timeToStation / 60) mins"
    }
}

extension ArrivalTime: Identifiable {
    var identifier: String {
        return id
    }
}
