//
//  NetworkManger.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import Foundation
import Combine

class NetworkManager {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
}

extension NetworkManager: Networkable {
    func fetchData<T>(endpoint: Endpoint) -> AnyPublisher<T, APIError> where T : Decodable {
        return session.dataTaskPublisher(for: endpoint.url)
            .receive(on: DispatchQueue.main)
            .mapError { APIError.network($0) }
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .mapError { _ in APIError.noData }
            .map { $0 }
            .eraseToAnyPublisher()
        
    }
}
