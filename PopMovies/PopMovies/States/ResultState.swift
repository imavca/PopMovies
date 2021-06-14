//
//  ResultState.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Movie])
    case failed(error: Error)
}
