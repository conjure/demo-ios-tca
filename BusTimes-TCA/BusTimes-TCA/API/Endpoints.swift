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
