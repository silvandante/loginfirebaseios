//
//  APIError.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 09/11/21.
//

import Foundation

enum APIError: Error {
    case network(Error)
    case noData(URLResponse?)
    case decoding(Error)
    case server(URLResponse?)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network(let error):
            return "Network: " + error.localizedDescription
        case .noData(let response):
            return "No data: " + (response.map {
                "response\($0)" } ?? "no response")
        case .decoding(let error):
            return "Decoding: " + error.localizedDescription
        case .server(let response):
            return "Server: " + (response.map {
                "response\($0)" } ?? "no response")
        }
    }
}
