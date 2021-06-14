//
//  MovieDetail.swift
//  PopMovies
//
//  Created by Carlos Martinez on 14/06/21.
//

import SwiftUI
import URLImage

struct MovieDetail: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
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
                            fetchPolicy: URLImageOptions.FetchPolicy.returnStoreElseLoad()
                        ))
                        .frame(width: 150, height: 200)
                    } else {
                        PlaceholderImageView()
                    }
                    VStack(alignment: .leading, spacing: 4){
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
                    }
                    .foregroundColor(.gray)
                    .font(.footnote)
                    
                }.padding(10)
                Text(movie.overview ?? "").padding(10)
                Spacer()
            }
        }
        .padding()
        .navigationBarTitle(Text(movie.title ?? ""), displayMode: .inline)
    }
}

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
}()

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: Movie.sampleMovie)
    }
}
