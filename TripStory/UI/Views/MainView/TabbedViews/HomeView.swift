//
//  HomeView.swift
//  TripStory
//
//  Created by Gon on 2021/01/21.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.injected) private var injected: DIContainer
    var body: some View {
        VStack {
            Text("Home")
            Button(
               action: { injected.interactors.logoutInteractor.logout() },
               label: { Text("Logout") }
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
