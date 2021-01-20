//
//  FindPasswordView.swift
//  TripStory
//
//  Created by Gon on 2021/01/13.
//

import SwiftUI

struct FindPasswordView: View {
    @Binding var username: String

    var body: some View {
        ZStack {
            Color.major.ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                TextField("UserID", text: $username)
                    .modifier(TextFieldModifier())
                Spacer().frame(height: 160)
                Button(action: {}/*@END_MENU_TOKEN@*/, label: {
                    Text("Find Password")
                        .modifier(ButtonModifier())
                })
                Spacer()
            }
            .padding(.horizontal, .horizontalPadding)
        }
        .navigationTitle("Find Password")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct FindPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        FindPasswordView(username: .constant("test"))
            .environment(\.locale, .init(identifier: "ko"))
    }
}
#endif
