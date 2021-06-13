//
//  PaginatedResponse.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import Foundation

struct PaginatedResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
