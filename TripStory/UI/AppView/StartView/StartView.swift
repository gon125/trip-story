//
//  StartView.swift
//  TripStory
//
//  Created by Gon on 2021/01/10.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.major.ignoresSafeArea()
                
                VStack {
                    Text("Trip Story")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text("You deserve a good trip!")
                        .font(.subtitle)
                    Spacer()
                    NavigationLink(
                        destination: LoginView()) {
                        Text("Log In")
                            .font(.buttonText)
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 47)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.major)
                    }
                    Spacer().frame(minHeight: 12, maxHeight: 18)
                    NavigationLink(
                        destination: SignUpView()) {
                        Text("Sign Up")
                            .font(.buttonText)
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 47)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.major)
                    }
                    Spacer().frame(height: 24)
                    HStack(alignment: .top) {
                        Image(systemName: "exclamationmark.circle.fill")
                        Text("Trip Story provides travel stories shared by members.")
                            .multilineTextAlignment(.center)
                            .font(.subtitle)
                    }
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
            }
        }
        // for navigation bar back button color
        .accentColor(.white)
        //.navigationBarBackButtonHidden(true)
    }
}

extension StartView {
    private struct styles {
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environment(\.locale, .init(identifier: "ko"))
    }
}
