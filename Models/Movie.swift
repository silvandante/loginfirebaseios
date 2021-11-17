//
//  Movie.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 09/11/21.
//

import Foundation

var defaultPoster = "https://www.genius100visions.com/wp-content/uploads/2017/09/placeholder-vertical.jpg"

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String
    
    var backdropPostURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w780\(posterPath ?? "")")!
    }
    
    var backdropCoverURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath ?? "")")!
    }
}
