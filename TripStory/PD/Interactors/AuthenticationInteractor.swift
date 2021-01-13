//
//  AuthenticationInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import Foundation

protocol AuthenticationInteractor {
    //func login(username: String, password: String)
    
}

struct DefaultAuthenticationInteractor: AuthenticationInteractor {
    
}

#if DEBUG
struct StubAuthenticationInteractor: AuthenticationInteractor {
    
}
#endif
