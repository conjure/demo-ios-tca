//
//  Effects.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 08/03/2023.
//

import Foundation
import ComposableArchitecture

final class Effects {
    static func busStopEffect(endpoint: Endpoints, decoder: JSONDecoder) -> EffectTask<TravelInformation> {
        guard let url = endpoint.url else { preconditionFailure("Can't create url for query: \(endpoint)") }

        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { APIError.network($0) }
            .map { data, _ in data }
            .decode(type: TravelInformation.self, decoder: decoder)
            .mapError { _ -> Never in preconditionFailure("Unable to decode the data") }
            .eraseToEffect()
    }
    
    static func arrivalTimeEffect(using string: String, decoder: JSONDecoder) -> EffectTask<[ArrivalTime]> {
        let url = "https://api.tfl.gov.uk/StopPoint/\(string)//arrivals"
        guard let busIdURL = URL(string: url) else { preconditionFailure("Can't create url for query: \(string)") }
        
        return URLSession.shared.dataTaskPublisher(for: busIdURL)
            .mapError { APIError.network($0) }
            .map { data, _ in data }
            .decode(type: [ArrivalTime].self, decoder: decoder)
            .mapError { _ -> Never in preconditionFailure("Unable to decode the data") }
            .eraseToEffect()
    }

}
