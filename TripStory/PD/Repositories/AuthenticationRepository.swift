//
//  AuthenticationRepository.swift
//  TripStory
//
//  Created by Gon on 2021/01/15.
//
import Combine

protocol AuthenticationRepository {
    func getToken() -> AnyPublisher<String?, Never>
    func createToken(with username: String, password: String) -> AnyPublisher<Result<String, AuthError>, Never>
    func deleteToken() -> AnyPublisher<Bool, Never>
}
