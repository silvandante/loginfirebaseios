//
//  SingleMovieUIView.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 14/11/21.
//

import SwiftUI

struct SingleMovieUIView: View {
    
    @ObservedObject private var singleMovieState = SingleMovieState()
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        self.singleMovieState.loadMovie(id: movie.id)
    }
    
    var body: some View {
        NavigationView {
            if(self.singleMovieState.movie != nil) {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            AsyncImage(url: movie.backdropCoverURL) { phase in
                                if let image = phase.image  {
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                } else if phase.error != nil {
                                    Image(systemName: "exclamationmark.triangle")
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250, alignment: .topLeading)
                                } else {
                                   LoadingUIView(
                                    isLoading: true,
                                    error: nil,
                                    retryAction: nil
                                   )
                               }
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250, alignment: .center)
                        }
                        .background(Color.gray)
                        .contentShape(Rectangle())
                        .aspectRatio(16/9, contentMode: .fit)
                        .cornerRadius(0)
                        .shadow(radius: 4)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 250, alignment: .topLeading)
                        HStack() {
                            Text(movie.title)
                            .fontWeight(.black)
                            Text(movie.releaseDate.split(separator: "-")[0])
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        HStack() {
                            Image(systemName: "star.circle")
                            Text(String(format: "%.1f",
                                        movie.voteAverage)+"/10")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        Text(movie.overview)
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                }
            } else {
                LoadingUIView(
                    isLoading: singleMovieState.isLoading,
                    error: singleMovieState.error) {
                        self.singleMovieState.loadMovie(id: movie.id)
                    }
            }
        }
        .onAppear() {
            self.singleMovieState.loadMovie(id: movie.id)
        }
    }
}

struct SingleMovieUIView_Previews: PreviewProvider {
    static var previews: some View {
        SingleMovieUIView(movie: Movie(
            id: 123,
            title: "Titulo de filme",
            backdropPath: "",
            posterPath: "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/adventure-movie-poster-template-design-7b13ea2ab6f64c1ec9e1bb473f345547_screen.jpg?ts=1576732289",
            overview: "Teste teste teste",
            voteAverage: 2.5,
            voteCount: 15,
            runtime: nil,
            releaseDate: ""
        ))
    }
}
