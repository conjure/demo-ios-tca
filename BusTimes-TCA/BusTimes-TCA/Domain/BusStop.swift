//
//  BusStop.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import Foundation

struct TravelInformation: Codable {
    var stopPoints: [BusStop]
}

extension TravelInformation: Equatable {}

struct BusStop: Codable, Hashable  {
    var id: String
    
    var naptanId: String
    var commonName: String
    var lines: [Lines]
}

extension BusStop: Identifiable {
    var identifier: String {
        return id
    }
}

struct Lines: Codable, Hashable {
    var name: String
}

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
