
import UIKit
import SwiftUI

final class Fonts {
    static let rubikSemibold16: UIFont = UIFont(name: "RubikRoman-SemiBold", size: 16)!
    
    static let rubikRegular12: UIFont = UIFont(name: "RubikRoman-Regular", size: 12)!
    static let rubikRegular14: UIFont = UIFont(name: "RubikRoman-Regular", size: 14)!
    static let rubikRegular16: UIFont = UIFont(name: "RubikRoman-Regular", size: 16)!
    static let rubikRegular18: UIFont = UIFont(name: "RubikRoman-Regular", size: 18)!
    static let rubikRegular30: UIFont = UIFont(name: "RubikRoman-Regular", size: 30)!
    
    static let rubikMedium12: UIFont = UIFont(name: "RubikRoman-Medium", size: 12)!
    static let rubikMedium14: UIFont = UIFont(name: "RubikRoman-Medium", size: 12)!
    static let rubikMedium16: UIFont = UIFont(name: "RubikRoman-Medium", size: 16)!
    static let rubikMedium18: UIFont = UIFont(name: "RubikRoman-Medium", size: 18)!
    static let rubikMedium36: UIFont = UIFont(name: "RubikRoman-Medium", size: 36)!
}

extension UIFont {
    func toFont() -> Font {
        return .custom(self.fontName, size: self.pointSize)
    }
}
