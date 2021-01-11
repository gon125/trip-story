//
//  Fonts.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI

extension Font {
    public static let navigationBarTitle = custom(nanumSquareBold, size: 26.0)
    public static let textInputTitle = custom(nanumSquareLight, size: 20.0)
    public static let regular = custom(nanumSquareRegular, size: 15.0)
    public static let textInputDescription = custom(nanumSquareLight, size: 10.0)
    
    fileprivate static let nanumSquareExtraBold = "NanumSquareEB"
    fileprivate static let nanumSquareLight = "NanumSquareL"
    fileprivate static let nanumSquareRegular = "NanumSquareR"
    fileprivate static let nanumSquareBold = "NanumSquareB"
}

extension UIFont {
    open class var navigationBarTitle: UIFont { UIFont(name: Font.nanumSquareBold, size: 26.0)! }
}
