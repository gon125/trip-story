//
//  LoadingButton.swift
//  TripStory
//
//  Created by Gon on 2021/01/15.
//

import SwiftUI

struct LoadingButtonView: View {
    let title: LocalizedStringKey
    @Binding var isLoading: Bool

    init(_ title: LocalizedStringKey, isLoading: Binding<Bool> = .init(.constant(false))!) {
        self.title = title
        self._isLoading = isLoading
    }

    var body: some View {
        self.content
            .modifier(ButtonModifier())
    }

    @ViewBuilder private var content: some View {
        if isLoading {
            ProgressView()
        } else {
            Text(title)
        }
    }
}

#if DEBUG
struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonView("test")
    }
}
#endif
