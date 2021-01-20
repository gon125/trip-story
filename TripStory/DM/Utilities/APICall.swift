//
//  APICall.swift
//  TripStory
//
//  Created by Gon on 2021/01/20.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

enum APIError: Error, CustomStringConvertible {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    var description: String {
        switch self {
        case .unexpectedResponse: return "unexpected response"
        case .invalidURL: return "invalid url"
        case let .httpCode(code): return "error with http code:\(code)"
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
