//
//  Endpoints.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import Foundation

struct Endpoints {
    let path: Path
    let queryItems: [URLQueryItem]
}

enum Path: String {
    case stopPoint = "/Stoppoint"
    case arrivals = "Stoppoint"
}

extension Endpoints {
    static func findLocalStops(using coordinates: Coordinate) -> Endpoints {
        return Endpoints(
            path: .stopPoint,
            queryItems: [
                URLQueryItem(name: "lat", value: String(describing: coordinates.latitude)),
                URLQueryItem(name: "lon", value: String(describing: coordinates.longitude)),
                URLQueryItem(name: "stoptypes", value: "NaptanPublicBusCoachTram"),
                URLQueryItem(name: "radius", value: "300"),
                URLQueryItem(name: "app_id", value: "25fb89a8"),
                URLQueryItem(name: "app_key", value: "d14564cd46a7d5cb31bc2c396038d68f")
        ])
    }
}


extension Endpoints {
    static func getBusTimeToStop(with busStopID: String) -> Endpoints {
        return Endpoints(
            path: .arrivals,
            queryItems: [
                URLQueryItem(name: "", value: ""),
        ])
    }
}

extension Endpoints {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.tfl.gov.uk"
        components.path = path.rawValue
        components.queryItems = queryItems
        return components.url
    }
}
