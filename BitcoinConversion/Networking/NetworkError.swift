//
//  NetworkError.swift
//  BitcoinConversion
//
//  Created by Antonio Mayorga on 5/2/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable {
    case failedToDecode
    case invalidRequest
    case invalidUrl
    case noDataFound
    case invalidData
    case customError(String)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            
        case .failedToDecode:
            return NSLocalizedString("Couldn't convert data into a readable format", comment: "")
            
        case .invalidUrl:
            return NSLocalizedString("Invalid URL", comment: "")
            
        case .invalidRequest:
            return NSLocalizedString("Could not complete request. Check internet connection and try again.", comment: "")
            
        case .invalidData:
            return NSLocalizedString("Malformed data received.", comment: "")
            
        case .noDataFound:
            return NSLocalizedString("No data could be retrieved.", comment: "")
        
        case .customError(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "")
        }
    }
}
