//
//  StartView.swift
//  TripStory
//
//  Created by Gon on 2021/01/10.
//

import SwiftUI

struct StartView: View {
    @Environment(\.injected) private var injected: DIContainer
    var body: some View {
        NavigationView {
            ZStack {
                Color.major.ignoresSafeArea()

                VStack {
                    Text("Trip Story")
                        .font(.customTitle)
                        .multilineTextAlignment(.center)
                    Text("You deserve a good trip!")
                        .font(.customSubtitle)
                    Spacer()
                    NavigationLink(
                        destination:
                            LoginView(
                                viewModel: .init(
                                    interactor: injected.interactors.loginInteractor,
                                    appState: injected.appState
                                )
                            )
                    ) {
                        Text("Log In")
                            .modifier(ButtonModifier())
                    }
                    Spacer().frame(minHeight: 12, maxHeight: 18)
                    NavigationLink(
                        destination: SignUpView(viewModel: .init(interactor: injected.interactors.signupInteractor))) {
                        Text("Sign Up")
                            .modifier(ButtonModifier())
                    }
                    Spacer().frame(height: 24)
                    HStack(alignment: .top) {
                        Image(systemName: "exclamationmark.circle.fill")
                        Text("Trip Story provides travel stories shared by members.")
                            .multilineTextAlignment(.center)
                            .font(.customSubtitle)
                    }
                    Spacer()

                }
                .foregroundColor(.white)
                .padding(.horizontal, .horizontalPadding)
            }
        }
        // for navigation bar back button color
        .accentColor(.white)
        // .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environment(\.locale, .init(identifier: "ko"))
    }
}
