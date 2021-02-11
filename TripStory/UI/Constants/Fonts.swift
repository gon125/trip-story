//
//  Fonts.swift
//  TripStory
//
//  Created by Gon on 2021/01/11.
//

import SwiftUI

extension Font {
    public static let customTitle = custom(nanumSquareRegular, size: 85)
    public static let customSubtitle = custom(nanumSquareRegular, size: 16)
    public static let buttonText = custom(nanumSquareRegular, size: 20)
}

extension Font {
    public static let navigationBarTitle = custom(nanumSquareBold, size: 26.0)
    public static let textInputTitle = custom(nanumSquareLight, size: 20.0)
    public static let regularText = custom(nanumSquareRegular, size: 15.0)
    public static let textInputDescription = custom(nanumSquareLight, size: 14.0)
}

extension Font {
    public static let tabbarText = custom(nanumSquareLight, size: 14.0)
}

// Home View
extension Font {
    public static let tableCellTitle = custom(nanumSquareBold, size: 26.0)
    public static let tableCellSubtitle = custom(nanumSquareRegular, size: 14.0)
}

// Video View
extension Font {
    public static let videoTitle = custom(nanumSquareRegular, size: 34)
    public static let videoSubtitle = custom(nanumSquareRegular, size: 12)
}

extension Font {
    fileprivate static let nanumSquareExtraBold = "NanumSquareEB"
    fileprivate static let nanumSquareLight = "NanumSquareL"
    fileprivate static let nanumSquareRegular = "NanumSquareR"
    fileprivate static let nanumSquareBold = "NanumSquareB"
}

extension UIFont {
    open class var navigationBarTitle: UIFont { UIFont(name: Font.nanumSquareBold, size: 26.0)! }
}
