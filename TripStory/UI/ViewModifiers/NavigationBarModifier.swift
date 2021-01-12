//
//  NavigationBarModifier.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI

//MARK - Navigation Bar Appearance
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.navigationBarTitle
        ]
        // remove back button text
        standardAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        standardAppearance.configureWithTransparentBackground()
        
        navigationBar.standardAppearance = standardAppearance
    }
}
