//
//  Networkable.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import Foundation
import Combine

protocol Networkable {
    func fetchData<T: Decodable>(endpoint: Endpoints) -> AnyPublisher<T, APIError>
    func fetchData<T: Decodable>(using string: String) -> AnyPublisher<T, APIError>
}
