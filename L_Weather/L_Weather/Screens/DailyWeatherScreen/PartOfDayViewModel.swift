
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
        return WeatherDisplayHelper.getTempAsString(partOfDay.tempAvg, displayMode: settings.tempDisplayMode)
    }
    
    var condition: String {
        return partOfDay.condition.toWeatherConditionLocalized()
    }
    
    var feelsLike: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTempAsString(partOfDay.feelsLike, displayMode: settings.tempDisplayMode)
    }
    
    var wind: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getWindSpeedAsString(partOfDay.windSpeed, displayMode: settings.windSpeedDisplayMode)
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
