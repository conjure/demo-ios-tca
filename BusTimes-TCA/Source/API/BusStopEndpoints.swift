//
//  BusStopEndpoints.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 14/03/2023.
//

import Foundation

enum BusStopEndpoint {
    case stopPoint(coordinate: Coordinate)
    case arrivals(busStopID: String)
}

extension BusStopEndpoint: Endpoint {
    var baseURL: String {
        return "https://api.tfl.gov.uk"
    }
    
    var path: String {
        switch self {
        case .stopPoint:
            return "Stoppoint"
        case .arrivals(let busStopID):
            return "Stoppoint/\(busStopID)/" + "/Arrivals"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .stopPoint(let coordinates):
            return [
                URLQueryItem(name: "lat", value: String(describing: coordinates.latitude)),
                URLQueryItem(name: "lon", value: String(describing: coordinates.longitude)),
                URLQueryItem(name: "stoptypes", value: "NaptanPublicBusCoachTram"),
                URLQueryItem(name: "radius", value: "300"),
                URLQueryItem(name: "app_id", value: Constants.transportForLondonAppID),
                URLQueryItem(name: "app_key", value: Constants.transportForLondonKey)
        ]
        case .arrivals:
            return []
        }
    }
}
