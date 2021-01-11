//
//  LoginView.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        ZStack {
            Color.major.ignoresSafeArea()
            Text("")
        }
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
