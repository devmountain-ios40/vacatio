//
//  NetworkError.swift
//  Vacatio
//
//  Created by Stephen Davis on 10/14/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case thrownError(Error)
    case invalidURL(URL)
    case nilParameters
    case couldNotDecode
    case redirectionError
    case clientError
    case serverError
    case invalidRequest
    case unknownError
    case noData
    
    var errorDescription: String? {
        switch self {
            case .thrownError(let error):
                return "\(error)"
            case .invalidURL(let url):
                return "Unable to reach the server. The following URL was requested: \(url.absoluteString)"
            case .nilParameters:
                return "Parameters were nil"
            case .couldNotDecode:
                return "Unable to decode the data, potentially an issue with model object(s), or with the process of decoding"
            case .redirectionError:
                return "Redirection error"
            case .clientError:
                return "Client error"
            case .serverError:
                return "Server error"
            case .invalidRequest:
                return "Invalid request"
            case .unknownError:
                return "Unknown error"
            case .noData:
                return "The server responded with no data"
        }
    }
}
