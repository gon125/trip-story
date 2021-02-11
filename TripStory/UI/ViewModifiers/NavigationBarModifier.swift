//
//  NavigationBarModifier.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI

// MARK: - Navigation Bar Appearance

// globally
extension UINavigationController {

    static var navigationBarTitleColor: UIColor?

    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.standardAppearance.backButtonAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.clear
        navigationBar.standardAppearance.configureWithTransparentBackground()
        navigationBar.standardAppearance.titleTextAttributes[.font] = UIFont.navigationBarTitle
        navigationBar.standardAppearance.titleTextAttributes[.foregroundColor] = UINavigationController.navigationBarTitleColor ?? .white
    }
}

// modifier
struct NavigationBarModifier: ViewModifier {

    var titleColor: UIColor?

    init(titleColor: UIColor?) {
        UINavigationController.navigationBarTitleColor = .black
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationBarTitleColor(titleColor: UIColor? = nil) -> some View {
        self.modifier(NavigationBarModifier(titleColor: titleColor))
    }
}
