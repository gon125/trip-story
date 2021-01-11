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
                        .font(.system(size: 85))
                        .multilineTextAlignment(.center)
                    Text("You deserve a good trip!")
                        .font(.system(size: 16))
                    Spacer()
                    NavigationLink(
                        destination: Text("login")) {
                        Text("Log In")
                            .font(.system(size: 20))
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 47)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.major)
                    }
                    Spacer().frame(minHeight: 12, maxHeight: 18)
                    NavigationLink(
                        destination: Text("sign up")) {
                        Text("Sign Up")
                            .font(.system(size: 20))
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
                            .font(.system(size: 16))
                    }
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
            }
        }
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
