//
//  Network.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 09/08/2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case errorParsingJSON
    case noInternetConnection
    case dataReturnedNil
    case returnedError(Error)
    case invalidStatusCode(Int)
    case customError(String)
}

extension NetworkError {
    
    func getErrorMessage() ->  String {
        
        var errorString = ""
        
        switch self {
        case .badURL:
            errorString = "URL is not supported."
        case .errorParsingJSON:
            errorString = "Json is not correct formatted."
        case .noInternetConnection:
            errorString = "No internet connection found"
        case .dataReturnedNil:
            errorString = "No data found"
        case .returnedError(let error):
            errorString = error.localizedDescription
        case .invalidStatusCode(let statusCode):
            errorString = "status Code: \(statusCode)"
        case .customError(let string):
            errorString = string
        }
        
        return errorString
    }
}
