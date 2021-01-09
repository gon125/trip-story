//
//  AuthenticationInteractor.swift
//  TripStory
//
//  Created by Gon on 2021/01/09.
//

import Foundation

protocol AuthenticationInteractor {
    
}

struct DefaultAuthenticationInteractor: AuthenticationInteractor {
    
}

#if DEBUG
struct StubAuthenticationInteractor: AuthenticationInteractor {
    
}
#endif
