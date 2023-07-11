//
//  File.swift
//  
//
//  Created by Abin Baby on 10.07.23.
//

import Foundation

public enum PEError: Error {

    case unableToComplete
    case invalidResponse
    case invalidData
    case networkError
    case noData
    case urlGeneration
    case PEError(statusCode: Int, data: Data?)
    case notConnected
    case generic

    public var description: String {
            switch self {
            case .unableToComplete:
                return "Unable to complete your request. Please check your internet connection"
            case .invalidResponse:
                return "Invalid response from the server. Please try again."
            case .invalidData:
                return "The data received from the server was invalid. Please try again."
            case .networkError:
                return "Could not complete operation due to nerwork error. Please try again."
            case .noData:
                return "No data received from server. Please try again"
            case .urlGeneration:
                return "Couldn't generate URL"
            case .PEError(statusCode: let statusCode, data: _):
                return "\(statusCode) error received."
            case .notConnected:
                return "Not connected to internet"
            case .generic:
                return "Sorry, something went wrong"
            }
        }
}

