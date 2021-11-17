//
//  MovieService.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 09/11/21.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(
        completion: @escaping (Result<MovieResponse, MovieError>) -> ()
    )
 
    func fetchMovie(
        id: Int,
        completion: @escaping (Result<Movie, MovieError>) -> ()
    )
}

enum MovieError: Error {
    case apiError
    case noData
    case serializationError
    case invalidEndpoint
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
            case .apiError:
                return "Failed fetching data"
            case .noData:
                return "No data"
            case .serializationError:
                return "Error serializing data"
            case .invalidEndpoint:
                return "Invalid endpoint"
            case .invalidResponse:
                return "Invalid response"
        }
    }

    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
