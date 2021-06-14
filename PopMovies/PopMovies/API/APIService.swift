//
//  APIService.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import Foundation
import Combine

// MARK: - Protocols

protocol APIBuilder {
    var baseUrl: URL { get }
    var apiKey: String { get }
}

protocol APIService {
    func request(from endpoint: Endpoint, parameters: [String: String]?) -> AnyPublisher<PaginatedResponse, APIError>
}

// MARK: - Endpoint

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
    var baseUrl: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var apiKey: String {
        return "3c693d71e8e7b20b63c8429eeb503f0b"
    }
}

// MARK: - API Service

struct MovieService: APIService {
    
    func request(from endpoint: Endpoint, parameters: [String: String]?) -> AnyPublisher<PaginatedResponse, APIError> {
        let queryUrl = endpoint.baseUrl.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryUrl, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: endpoint.apiKey),
            URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
        ]
        if let params = parameters {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown }
            .flatMap{ data, response -> AnyPublisher<PaginatedResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: PaginatedResponse.self, decoder: jsonDecoder)
                        .mapError{ _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

