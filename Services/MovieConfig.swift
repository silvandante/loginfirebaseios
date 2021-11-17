//
//  MovieConfig.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 09/11/21.
//

import Foundation

class MovieConfig: MovieService {
    
    static let shared = MovieConfig()
    
    private init() {}
    
    private let apiKey = "4b7f32f602241c55fc0b38e3612322e6"
    private let baseAPIUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/movie/top_rated") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadUrlAndDecode(
            url: url,
            completion: completion
        )
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadUrlAndDecode(
            url: url,
            params: ["append_to_response" : "video,credits"],
            completion: completion
        )
    }
    
    private func loadUrlAndDecode<D: Decodable>(
        url: URL,
        params: [String: String]? = nil,
        completion: @escaping(Result<D, MovieError>) -> ()
    ) {
        guard var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        ) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map {
                URLQueryItem(
                    name: $0.key,
                    value: $0.value
                )
            })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalUrl) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(
                    with: .failure(.apiError),
                    completion: completion
                )
                return
            }
            
            let validStatusCodes = 200..<300
            
            guard let httpResponse = response as? HTTPURLResponse,
                  validStatusCodes.contains(httpResponse.statusCode) else {
                self.executeCompletionHandlerInMainThread(
                    with: .failure(.invalidResponse),
                    completion: completion
                )
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(
                    with: .failure(.noData),
                    completion: completion
                )
                return
            }
            
            do {
                let value = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(
                    with: .success(value),
                    completion: completion
                )
            } catch let error as NSError {
                print("ERROR:\(error)")
                self.executeCompletionHandlerInMainThread(
                    with: .failure(.serializationError),
                    completion: completion
                )
            }
        }.resume()
    }

    
    private func executeCompletionHandlerInMainThread<D: Decodable>(
        with result: Result<D, MovieError>,
        completion: @escaping(Result<D, MovieError>) -> ()
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
}
