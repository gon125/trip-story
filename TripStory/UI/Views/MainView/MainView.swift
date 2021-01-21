//
//  MainView.swift
//  TripStory
//
//  Created by Gon on 2021/01/10.
//

import SwiftUI

struct MainView: View {
    @Environment(\.injected) private var injected: DIContainer
    var body: some View {
        ZStack {
            Color.major.ignoresSafeArea()
            VStack {
                Text("Main")
                Button(
                    action: { injected.interactors.logoutInteractor.logout() },
                    label: { Text("Logout") }
                )
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
