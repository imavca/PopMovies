//
//  Movie.swift
//  PopMovies
//
//  Created by Carlos Martínez on 13/06/21.
//

import Foundation

struct Movie: Codable, Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath : String?
    let releaseDate: Date?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    static var sampleMovie: Movie {
        .init(adult: false,
              backdropPath: "/6MKr3KgOLmzOP6MSuZERO41Lpkt.jpg",
              genreIDS: [35, 80],
              id: 337404,
              originalLanguage: "en",
              originalTitle: "Cruella",
              overview: "In 1970s London amidst the punk rock revolution, a young grifter named Estella is determined to make a name for herself with her designs. She befriends a pair of young thieves who appreciate her appetite for mischief, and together they are able to build a life for themselves on the London streets. One day, Estella’s flair for fashion catches the eye of the Baroness von Hellman, a fashion legend who is devastatingly chic and terrifyingly haute. But their relationship sets in motion a course of events and revelations that will cause Estella to embrace her wicked side and become the raucous, fashionable and revenge-bent Cruella.",
              popularity: 5055.01,
              posterPath: "/rTh4K5uw9HypmpGslcKd4QfHl93.jpg",
              releaseDate: Date(),
              title: "Cruella",
              video: false,
              voteAverage: 8.7,
              voteCount: 2435)
    }
}
