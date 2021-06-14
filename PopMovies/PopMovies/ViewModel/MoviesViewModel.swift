//
//  MoviesViewModel.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import Foundation
import Combine

protocol ActionsViewModel {
    func getMovies()
}

class MoviesViewModel: ObservableObject, ActionsViewModel {
    private let service: APIService
    private(set) var movies = [Movie]()
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var totalPages = 1
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: APIService) {
        self.service = service
    }
    
    func getMovies() {
        guard currentPage <= totalPages else {
            return
        }
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .popular, parameters: ["page": "\(currentPage)"])
            .sink{ res in
                switch res {
                case .finished:
                    self.state = .success(content: self.movies)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.totalPages = response.totalPages ?? 1
                self.currentPage += 1
                if let newMovies = response.results {
                    self.movies.append(contentsOf: newMovies)
                }
            }
        
        self.cancellables.insert(cancellable)
    }
    
    func isLastMovie(_ movie: Movie) -> Bool {
        if let last = self.movies.last {
            return last.id == movie.id
        }
        return false
    }
}


