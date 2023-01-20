
import Foundation

final class ForecastViewModel {
    
    private let forecast: Forecast
    private let settingsProvider: SettingsProviderProtocol
    
    init (forecast: Forecast, settingsProvider: SettingsProviderProtocol) {
        self.forecast = forecast
        self.settingsProvider = settingsProvider
    }
    
    var dateAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: forecast.date) else {return ""}
        
        dateFormatter.dateFormat = "dd/MM"
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    var icon: String {
        return forecast.parts.day.icon
    }
    
    var cloudness: String {
        let cloudnessStr = String(format: "%0.f", forecast.parts.day.cloudness * 100) + "%"
        return cloudnessStr
    }
    
    var condtion: String {
        let conditionLocalized = forecast.parts.day.condition.toWeatherConditionLocalized()
        return conditionLocalized
    }
    
    var tempRange: String {
        let settings = settingsProvider.get()
        
        var tempRangeStr = ""
        if settings.tempDisplayMode == .celsius {
            tempRangeStr = "\(forecast.parts.day.tempMin)\u{00B0} \(forecast.parts.day.tempMax)\u{00B0}"
        } else {
            tempRangeStr = "\(Int(forecast.parts.day.tempMin.toFahrengeit()))\u{00B0} \(Int(forecast.parts.day.tempMax.toFahrengeit()))\u{00B0}"
        }
        
        return tempRangeStr
    }
}