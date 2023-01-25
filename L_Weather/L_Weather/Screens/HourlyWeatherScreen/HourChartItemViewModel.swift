
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
        let date = Calendar.current.date(byAdding: .hour, value: Int(hour.hour)!, to: date)!
        
        let settings = settingsProvider.get()
        if settings.timeFormat == .hours12 {
            return date.toString(format: "hh:mm a")
        }
        
        return date.toString(format: "HH:mm")
    }
    
    var temp: Int {
        let settings = settingsProvider.get()
        return settings.tempDisplayMode == .celsius ? Int(hour.temp) : Int(hour.temp.toFahrengeit())
    }
    
    var tempAsString: String {
        return "\(temp)\u{00B0}"
    }
    
    var precipitation: Double {
        return hour.precProb
    }
    
    var precipitationAsString: String {
        return String(format: "%.0f", hour.precProb) + "%"
    }
}
