
import Foundation

final class HourChartItemViewModel : Identifiable {
    private let date: Date
    private let hour: Hour
    
    private let settingsProvider: SettingsProviderProtocol
    
    init (date: Date, hour: Hour, settingsProvider: SettingsProviderProtocol) {
        self.date = date
        self.hour = hour
        self.settingsProvider = settingsProvider
    }
    
    var id: Int {
        return Int(hour.hour)!
    }
    
    var hourNumber: Int {
        return Int(hour.hour)!
    }
    
    var timeAsString: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTimeAsString(date: date, hourNumber: Int(hour.hour)!, timeFormat: settings.timeFormat)
    }
    
    var temp: Int {
        let settings = settingsProvider.get()
        return settings.tempDisplayMode == .celsius ? Int(hour.temp) : Int(hour.temp.toFahrengeit())
    }
    
    var tempAsString: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTempAsString(hour.temp, displayMode: settings.tempDisplayMode)
    }
    
    var precipitation: Double {
        return hour.precProb
    }
    
    var precipitationAsString: String {
        return String(format: "%.0f", hour.precProb) + "%"
    }
}
