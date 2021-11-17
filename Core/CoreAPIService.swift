//
//  CoreAPIService.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 09/11/21.
//

import Foundation

guard
    let defaultBaseURL: URL = URL(string: "https://api.themoviedb.org"),
        try? Data(contentsOf: URL)
        else { return }

class CoreAPIService {
    let networking: Networking
    let baseURL: URL
    
    init(
        networking: Networking = URLSession.shared,
        baseURL: URL = defaultBaseURL
    ) {
        self.networking = networking
        self.baseURL = baseURL
    }
    
    func perform<T: Decodable>(
        request: URLRequest,
        completion: @escaping(Result<T, APIError>) -> Void
    ) {
        func callback(_ result: Result<T, APIError>) {
            DispatchQueue.main.sync {
                completion(result)
            }
        }
        
        networking.perform(with: request) { (data, response, error) in
            if let error = error {
                let apiError = APIError.network(error)
                let result: Result<T, APIError> = .failure(apiError)
                callback(result)
                return
            }
            guard let data = data else {
                let apiError = APIError.noData(response)
                let result: Result<T, APIError> = .failure(apiError)
                callback(result)
                return
            }
            
            let validStatusCodes = 200..<300
            
            guard let httpResponse = response as? HTTPURLResponse,
                  validStatusCodes.contains(httpResponse.statusCode) else {
                let apiError = APIError.server(response)
                let result: Result<T, APIError> = .failure(apiError)
                callback(result)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                let result: Result<T, APIError> = .success(value)
                callback(result)
            } catch {
                let apiError = APIError.server(response)
                let result: Result<T, APIError> = .failure(apiError)
                callback(result)
            }
        }
    }
    
    
}
