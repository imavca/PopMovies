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
    @Published private(set) var state: ResultState = .loading
    
    init(service: APIService) {
        self.service = service
    }
    
    func getMovies() {
        self.state = .loading
        
        let cancellable = service
            .request(from: .popular, parameters: nil)
            .sink{ res in
                switch res {
                case .finished:
                    self.state = .success(content: self.movies)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.movies = response.results
            }
        
        self.cancellables.insert(cancellable)
    }
    
}


