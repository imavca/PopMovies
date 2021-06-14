//
//  MovieView.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import SwiftUI
import URLImage

struct MovieView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            if let posterPath = movie.posterPath,
               let url = Endpoint.ImageSize.medium.path(poster: posterPath) {
                URLImage(url, identifier: String(movie.id ?? 0)) {_ in
                } failure: { error, _ in
                    PlaceholderImageView()
                } content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .environment(\.urlImageOptions, URLImageOptions(
                    fetchPolicy: URLImageOptions.FetchPolicy.returnStoreElseLoad(downloadDelay: 0.25)
                ))
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            } else {
                PlaceholderImageView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text(formatter.string(from: movie.releaseDate ?? Date()))
                    .font(.subheadline)
                    .foregroundColor(.primary)
                HStack {
                    Text("Popularity Score:")
                    Text(String(format: "%.1f",
                                (movie.popularity ?? 0.0) / 100))
                }
                .foregroundColor(.gray)
                .font(.footnote)
            }
        }
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
}()

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie.sampleMovie)
            .previewLayout(.sizeThatFits)
    }
}
