
import Foundation
import UIKit

final class Colors {
    
    final class Settings {
        static let background = UIColorUtils.CreateFromRGB(red: 32, green: 78, blue: 199)
        static let panelBackground = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        static let panelTextColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        static let switchIsOnBackground = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
    }
    
    final class Onboarding {
        static let background = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    final class Global {
        static let buttonColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
    }
    
}

public class UIColorUtils {
    public static func CreateFromRGB(red: uint, green: uint, blue: uint) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
