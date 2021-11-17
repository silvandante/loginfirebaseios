//
//  MovieCardUIView.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 10/11/21.
//

import SwiftUI

struct MovieCardUIView: View {
    
    let movie: Movie
    let openMovieDetail: (Movie) -> Void
    
    @ObservedObject var imageLoader = ImageLoader()
    
    @State private var showingAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                AsyncImage(url: movie.backdropPostURL) { phase in
                    if let image = phase.image  {
                        image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if phase.error != nil {
                        Image(systemName: "exclamationmark.triangle")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 75, maxHeight: 75, alignment: .center)
                    } else {
                       LoadingUIView(
                        isLoading: true,
                        error: nil,
                        retryAction: nil
                       )
                   }
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 185, maxHeight: 185, alignment: .center)
            }
            .background(Color.gray)
            .contentShape(Rectangle())
            .cornerRadius(8)
            .shadow(radius: 4)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 185, maxHeight: 185, alignment: .topLeading)
        }
        .contentShape(Rectangle())
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 185, maxHeight: 185, alignment: .topLeading)
        .gesture(TapGesture().onEnded {
            openMovieDetail(movie)
        })
    }
}

struct MovieCardUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieCardUIView(
            movie: Movie(
                id: 123,
                title: "Titulo de filme",
                backdropPath: "",
                posterPath: "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/adventure-movie-poster-template-design-7b13ea2ab6f64c1ec9e1bb473f345547_screen.jpg?ts=1576732289",
                overview: "",
                voteAverage: 2.5,
                voteCount: 15,
                runtime: nil,
                releaseDate: ""
            ),
            openMovieDetail: openMovieDetail
        )
    }
    
    static func openMovieDetail(movie: Movie) {
    }

}
