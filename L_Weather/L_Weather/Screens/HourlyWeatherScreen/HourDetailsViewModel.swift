
import Foundation

final class HourDetailsViewModel {
    
    private let date: Date
    private let hour: Hour
    
    private let settingsProvider: SettingsProviderProtocol
    
    init (date: Date, hour: Hour, settingsProvider: SettingsProviderProtocol) {
        self.date = date
        self.hour = hour
        self.settingsProvider = settingsProvider
    }
    
    var dateAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd/MM"
        return dateFormatter.string(from: Date()).lowercased()
    }
    
    var timeAsString: String {
        let date = Calendar.current.date(byAdding: .hour, value: Int(hour.hour)!, to: date)!
        
        let settings = settingsProvider.get()
        if settings.timeFormat == .hours12 {
            return date.toString(format: "hh:mm")
        }
        
        return date.toString(format: "HH:mm")
    }
    
    var temp: String {
        let settings = settingsProvider.get()
        return settings.tempDisplayMode == .celsius ? "\(hour.temp)\u{00B0}" : "\(Int(hour.temp.toFahrengeit()))\u{00B0}"
    }
    
    var feelsLike: String {
        let settings = settingsProvider.get()
        
        if (settings.tempDisplayMode == .celsius) {
            return "\(hour.feelsLike)\u{00B0}"
        }
        
        return String(Int(hour.feelsLike.toFahrengeit())) + "\u{00B0}"
    }
    
    var wind: String {
        let settings = settingsProvider.get()
        
        if (settings.windSpeedDisplayMode == .kilometers) {
            return "\(String(format: "%.0f", hour.windSpeed)) m\\s \(hour.windDir.toWindDirectionLocalized())"
        }
        
        return "\(String(format: "%.0f", hour.windSpeed.toMilesPerHour())) mi\\h \(hour.windDir.toWindDirectionLocalized())"
    }
    
    var precipitation: String {
        return String(format: "%.0f", hour.precProb) + "%"
    }
    
    var cloudness: String {
        return String(format: "%.0f", hour.cloudness) + "%"
    }
}
