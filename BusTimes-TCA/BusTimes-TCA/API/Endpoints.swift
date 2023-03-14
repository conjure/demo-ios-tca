//
//  Endpoints.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var url: URL { get }
    var queryItems: [URLQueryItem] { get }
}

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

extension Endpoint {
    internal var url: URL {
        var urlStr = baseURL + "/" + path
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        var url = URL(string: urlStr)!
        url.append(queryItems: queryItems)
        return url
    }
}
