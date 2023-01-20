
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
        static let background = UIColorUtils.CreateFromRGB(red: 32, green: 78, blue: 199)
    }
    
    final class Global {
        static let buttonColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
    }
    
    final class Weather {
        static let background = UIColor.white
        static let dateAndTimeColor = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        static let todayPanelBacground = UIColorUtils.CreateFromRGB(red: 32, green: 78, blue: 199)
        static let panelBackground = UIColorUtils.CreateFromRGB(red: 32, green: 78, blue: 199)
        
        final class Hourly {
            static let titleColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
            static let hourBorderColor = UIColorUtils.CreateFromRGB(red: 155, green: 172, blue: 228)
            static let hourSelectedBackground = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        }
        
        final class Daily {
            static let dateColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
            static let cloudnessColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            static let backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        }
    }
}

public class UIColorUtils {
    public static func CreateFromRGB(red: uint, green: uint, blue: uint) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
