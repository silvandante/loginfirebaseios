//
//  MovieListState.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 10/11/21.
//

import Foundation

class MovieListState: ObservableObject {
    
    private let movieService: MovieService
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
   
    init(movieService: MovieService = MovieConfig.shared) {
        self.movieService = movieService
    }
    
    func loadMovies() {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies() { [weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
                case .success(let response):
                    self.movies = response.results
                    
                case .failure(let error):
                    self.error = error as NSError
            }
            
        }
    }
    
}
