//
//  Networkable.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import Foundation
import Combine

protocol Networkable {
    func fetchData<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, APIError>
}
