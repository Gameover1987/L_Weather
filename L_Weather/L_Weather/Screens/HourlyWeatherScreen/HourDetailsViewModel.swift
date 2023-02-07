
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
        dateFormatter.locale = Locale(identifier: "RU")
        let dateAsString = dateFormatter.string(from: Date()).lowercased()
        return dateAsString
    }
    
    var timeAsString: String {
        let settings = settingsProvider.get()
        var timeAsString = WeatherDisplayHelper.getTimeAsString(date: date, hourNumber: Int(hour.hour)!, timeFormat: settings.timeFormat)
        return timeAsString
    }
    
    var temp: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTempAsString(hour.temp, displayMode: settings.tempDisplayMode)
    }
    
    var feelsLike: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTempAsString(hour.feelsLike, displayMode: settings.tempDisplayMode)
    }
    
    var wind: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getWindSpeedAsString(hour.windSpeed, displayMode: settings.windSpeedDisplayMode)
    }
    
    var precipitation: String {
        return String(format: "%.0f", hour.precProb) + "%"
    }
    
    var cloudness: String {
        return String(format: "%.0f", hour.cloudness) + "%"
    }
}
