////
////  CustomTabView.swift
////  TripStory
////
////  Created by Gon on 2021/01/28.
////
//
// import SwiftUI
//
// struct CustomTabView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
//    @Binding private var selection: SelectionValue
//
//    init(selection: Binding<SelectionValue>?, @ViewBuilder content: () -> Content) {
//        guard let selection = selection else {
//            return
//        }
//        self._selection = selection
//
//    }
//
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
// }
//
// extension CustomTabView where SelectionValue == Int {
//    init(@ViewBuilder content: () -> Content) {
//
//    }
// }
// struct CustomTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTabView {
//
//        }
//    }
// }
