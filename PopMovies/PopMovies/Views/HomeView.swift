//
//  HomeView.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = MoviesViewModel(service: MovieService())
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getMovies)
            case .success(let movies):
                NavigationView {
                    List(movies) { item in
                        NavigationLink(
                            destination: MovieDetail(movie: item)) {
                            MovieView(movie: item)
                                .onAppear {
                                    itemOnAppear(item)
                                }
                        }
                    }
                    .navigationTitle(Text("Popular Movies"))
                }
            }
            
        }.onAppear(perform: viewModel.getMovies)
    }
    
    private func itemOnAppear(_ movie: Movie) {
        if viewModel.isLastMovie(movie) {
            viewModel.getMovies()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
