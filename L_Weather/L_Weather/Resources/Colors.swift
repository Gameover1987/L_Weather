
import Foundation
import UIKit
import SwiftUI

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
            
            static let tableBackground = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
            static let tableSeparatorColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            static let tableTextColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
            
            static let hourChartLineColor = UIColorUtils.CreateFromRGB(red: 25, green: 53, blue: 184)
            
            static let positiveTempGradient = Gradient(colors: [
                Color(red: 61/255.0, green: 105/255.0, blue: 220/225.0, opacity: 0.3),
                Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0.3),
                Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0)
            ])
            
            static let negativeTempGradient = Gradient(colors: [
                Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0),
                Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0.3),
                Color(red: 61/255.0, green: 105/255.0, blue: 220/225.0, opacity: 0.3)
            ])
        }
        
        final class Daily {
            static let dateColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
            static let cloudnessColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            static let backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
            static let dayOfWeekSelectedBackground = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            
            static let partOfDayBackground = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
            static let partOfDaySeparatorColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            
            static let sunAndMoonTextColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        }
    }
}

public class UIColorUtils {
    public static func CreateFromRGB(red: uint, green: uint, blue: uint) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
