//
//  MovieListUIView.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 10/11/21.
//

import SwiftUI

struct MovieListUIView: View {
    
    @ObservedObject private var movieListState = MovieListState()
    var _openMovieDetail: (Movie) -> ()
    
    init(_openMovieDetail: @escaping (Movie) -> ()) {
        self._openMovieDetail = _openMovieDetail
        self.movieListState.loadMovies()
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        if(self.movieListState.movies != nil) {
                            ForEach(self.movieListState.movies!) { movie in
                                MovieCardUIView(movie: movie, openMovieDetail: _openMovieDetail)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            }
                        } else {
                            LoadingUIView(
                                isLoading: movieListState.isLoading,
                                error: movieListState.error) {
                                    movieListState.loadMovies()
                                }
                        }
                    }
                }
                .padding(20)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
        }
    }
}

struct MovieListUIView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListUIView(_openMovieDetail: openMovieDetail)
    }
    
    static func openMovieDetail(movie: Movie) {
    }

}
