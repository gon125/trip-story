//
//  WebRepository.swift
//  TripStory
//
//  Created by Gon on 2021/01/20.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension WebRepository {
    func call<Value>(
        endpoint: APICall,
        httpCodes: HTTPCodes = .success
    ) -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .tryMap {
                    assert(!Thread.isMainThread)
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.unexpectedResponse
                    }
                    guard httpCodes.contains(code) else {
                        throw APIError.httpCode(code)
                    }
                    return $0.data
                }
                .decode(type: Value.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Value, Error>(error: error)
                .eraseToAnyPublisher()
        }
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
//    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
//        return tryMap { value in
//            assert(!Thread.isMainThread)
//        }
//    }
}
