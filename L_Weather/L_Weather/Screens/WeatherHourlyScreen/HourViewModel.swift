
import Foundation

final class HourViewModel {
    
    private let settings: Settings
    
    let time: String
    let iconName: String
    let temp: String
    
    init (by hour: Hour, settings: Settings) {
        self.settings = settings
        
        self.time = WeatherHelper.getTimeFromUnixFormatAsString(unixDate: hour.hourTs, format: self.settings.timeFormat)
        self.iconName = hour.icon
        self.temp = settings.tempDisplayMode == .celsius ? "\(hour.temp)\u{00B0}" : "\(hour.temp.toFahrengeit())\u{00B0}"
    }
}

final class WeatherHelper {
    static func getTimeFromUnixFormatAsString(unixDate: Double, format: TimeFormat) -> String {
        let date = Date(timeIntervalSince1970: unixDate)
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format == .hours12 ? "hh:mm" : "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
