
import Foundation

final class PartOfDayViewModel {
    private let partOfDay: PartOfDayProtocol
    private let settingsProvider: SettingsProviderProtocol
    
    init (partOfDay: PartOfDayProtocol, settingsProvider: SettingsProviderProtocol) {
        self.settingsProvider = settingsProvider
        self.partOfDay = partOfDay
    }
    
    var name: String {
        return partOfDay.name
    }
    
    var icon: String {
        return partOfDay.icon
    }
    
    var temp: String {
        let settings = settingsProvider.get()
        
        if (settings.tempDisplayMode == .celsius) {
            return "\(partOfDay.tempAvg)\u{00B0}"
        }
        
        return String(Int(partOfDay.tempAvg.toFahrengeit())) + "\u{00B0}"
    }
    
    var condition: String {
        return partOfDay.condition.toWeatherConditionLocalized()
    }
    
    var feelsLike: String {
        let settings = settingsProvider.get()
        
        if (settings.tempDisplayMode == .celsius) {
            return "\(partOfDay.feelsLike)\u{00B0}"
        }
        
        return String(Int(partOfDay.feelsLike.toFahrengeit())) + "\u{00B0}"
    }
    
    var wind: String {
        let settings = settingsProvider.get()
        
        if (settings.windSpeedDisplayMode == .kilometers) {
            return "\(String(format: "%.0f", partOfDay.windSpeed)) m\\s \(partOfDay.windDir.toWindDirectionLocalized())"
        }
        
        return "\(String(format: "%.0f", partOfDay.windSpeed.toMilesPerHour())) mi\\h \(partOfDay.windDir.toWindDirectionLocalized())"
    }
    
    var uvIndex: String {
        guard let uvIndexStr = partOfDay.uvIndex else {
            return "нет даных"
        }
        
        return String(uvIndexStr)
    }
    
    var precipitation: String {
        return String(format: "%.0f", partOfDay.precProb) + "%"
    }
    
    var cloudness: String {
        return String(format: "%.0f", partOfDay.cloudness) + "%"
    }
}
