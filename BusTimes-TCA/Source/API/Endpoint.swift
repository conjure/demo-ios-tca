//
//  Endpoints.swift
//  BusTimes-TCA
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

extension Endpoint {
    var url: URL {
        var urlStr = baseURL + "/" + path
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        var url = URL(string: urlStr)!
        url.append(queryItems: queryItems)
        return url
    }
}
