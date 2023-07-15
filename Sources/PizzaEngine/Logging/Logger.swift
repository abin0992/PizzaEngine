//
//  Logger.swift
//  
//
//  Created by Abin Baby on 10.07.23.
//

import Foundation

public func DLog(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        NSLog("[\((filename as NSString).lastPathComponent):\(line) (\(function))] \(message)")
    #endif
}

protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: PEError)
}

// MARK: - Logger

internal class DefaultNetworkErrorLogger: NetworkErrorLogger {
    public init() { }

    public func log(request: URLRequest) {
        DLog("-------------")
        DLog("request: \(request.url!)")
        if let httpHeaders = request.allHTTPHeaderFields {
            DLog("headers: \(httpHeaders)")
        }
        
        DLog("method: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            DLog("body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            DLog("body: \(String(describing: resultString))")
        }
    }

    public func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            DLog("responseData: \(String(describing: dataDict))")
        }
    }

    public func log(error: PEError) {
        DLog("\(error.description)")
    }
}

