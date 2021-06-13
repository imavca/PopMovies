//
//  APIService.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var apiKey: String { get }
}

enum Endpoint {
    case popular
    
    func path() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        }
    }
}

extension Endpoint: APIBuilder {
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path()))
    }
    
    var baseUrl: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var apiKey: String {
        return "3c693d71e8e7b20b63c8429eeb503f0b"
    }
}
