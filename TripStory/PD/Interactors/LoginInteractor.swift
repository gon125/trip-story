//
//  LoginInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/17.
//

import Combine

protocol LoginInteractor {
    func login(username: Published<String>, password: Published<String>)
}
