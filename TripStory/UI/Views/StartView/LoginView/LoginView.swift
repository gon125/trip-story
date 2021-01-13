//
//  LoginView.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var loginFailed: Bool = false
    
    var body: some View {
        ZStack {
            Color.major.ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                TextField("UserID", text: $id)
                    .modifier(TextFiledModifier())
                Spacer().frame(height: 40)
                SecureField("Password", text: $password)
                    .modifier(TextFiledModifier())
                Spacer().frame(height: 20)
                HStack { Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Forgot password?")
                            .modifier(TextButtonModifier())
                    }
                    
                }
                Spacer().frame(height: 60)
                Button(action: { }) {
                    Text("Sign In")
                        .modifier(ButtonModifier())
                }
                Spacer()
            }
            .padding(.horizontal, .horizontalPadding)
        }
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().inject(.preview)
            .environment(\.locale, .init(identifier: "ko"))
    }
}
#endif
