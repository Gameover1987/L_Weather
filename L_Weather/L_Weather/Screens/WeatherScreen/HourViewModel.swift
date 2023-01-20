
import Foundation

final class HourViewModel {
    
    private let settingsProvider: SettingsProviderProtocol
    private let hour: Hour
    
    init (by hour: Hour, settingsProvider: SettingsProviderProtocol) {
        self.settingsProvider = settingsProvider
        self.hour = hour
    }
    
    var time: String {
        let settings = settingsProvider.get()
        return WeatherHelper.getTimeFromUnixFormatAsString(unixDate: hour.hourTs, format: settings.timeFormat)
    }
    
    var iconName: String {
        return hour.icon
    }
    
    var temp: String {
        let settings = settingsProvider.get()
        return settings.tempDisplayMode == .celsius ? "\(hour.temp)\u{00B0}" : "\(Int(hour.temp.toFahrengeit()))\u{00B0}"
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
