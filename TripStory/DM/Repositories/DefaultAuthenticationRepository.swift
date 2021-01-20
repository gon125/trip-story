//
//  DefaultAuthenticationRepository.swift
//  TripStory
//
//  Created by Gon on 2021/01/20.
//

import Foundation
import Combine

struct DefaultAuthenticationRepository: AuthenticationRepository, WebRepository {
    var session: URLSession
    var baseURL: String
    func getToken() -> AnyPublisher<String, Error> {
        Future { promise in
            promise(.success(""))
        }
        .eraseToAnyPublisher()
    }

    func getToken(with username: String, password: String) -> AnyPublisher<Result<String, AuthError>, Never> {
        let request: AnyPublisher<String, Error> = call(endpoint: API.getToken(username: username, password: password))

        return request
            .map { Result<String, AuthError>.success($0) }
            .catch { _ in Just<Result<String, AuthError>>(.failure(AuthError.noMatchingUsername))}
            .eraseToAnyPublisher()
    }
}

extension DefaultAuthenticationRepository {
    enum API {
        case getToken(username: String, password: String)
    }
}

extension DefaultAuthenticationRepository.API: APICall {
    var path: String {
        switch self {
        case .getToken: return "/user/login"
        }
    }

    var method: String {
        switch self {
        case .getToken: return "POST"
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Accept": "application/json"]
    }

    func body() throws -> Data? {
        switch self {
        case let .getToken(username, password):
            let params = ["id": username, "pw": password] as Dictionary
            let body: Data
            do {
                try body = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print(error)
                return nil
            }
            return body
        }
    }

}
