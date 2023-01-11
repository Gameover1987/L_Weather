
import Foundation
import UIKit

final class Colors {
    static let onboardingBackground = UIColorUtils.CreateFromRGB(red: 32, green: 78, blue: 199)
    
    static let settingsBackground = UIColorUtils.CreateFromRGB(red: 32, green: 78, blue: 199)
    static let settingsPanelBackground = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
    
    static let orangeButtonColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
}

public class UIColorUtils {
    public static func CreateFromRGB(red: uint, green: uint, blue: uint) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
