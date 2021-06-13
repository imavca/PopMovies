//
//  APIError.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Fail to decode object from the service"
        case .errorCode(let code):
            return "Something went wrong, error code: \(code)"
        default:
            return "Unknown Error"
        }
    }
}
