//
//  SettingsView.swift
//  TripStory
//
//  Created by Gon on 2021/01/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.injected) var injected: DIContainer
    var body: some View {
        Button(
           action: { injected.interactors.logoutInteractor.logout() },
           label: { Text("Logout") }
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
