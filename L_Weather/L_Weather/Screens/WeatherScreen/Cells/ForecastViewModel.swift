
import Foundation

final class ForecastViewModel {

    private let forecast: Forecast
    private let settingsProvider: SettingsProviderProtocol
    
    init (forecast: Forecast, settingsProvider: SettingsProviderProtocol) {
        self.forecast = forecast
        self.settingsProvider = settingsProvider
        
        self.morning = PartOfDayViewModel(partOfDay: forecast.parts.morning, settingsProvider: settingsProvider)
        self.day = PartOfDayViewModel(partOfDay: forecast.parts.day, settingsProvider: settingsProvider)
        self.evening = PartOfDayViewModel(partOfDay: forecast.parts.evening, settingsProvider: settingsProvider)
        self.night = PartOfDayViewModel(partOfDay: forecast.parts.night, settingsProvider: settingsProvider)
    }
    
    var morning: PartOfDayViewModel
    var day: PartOfDayViewModel
    var evening: PartOfDayViewModel
    var night: PartOfDayViewModel
    
    var dateAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: forecast.date) else {return ""}
        
        dateFormatter.dateFormat = "dd/MM"
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: forecast.date) else {return ""}
        
        dateFormatter.dateFormat = "dd/MM E"
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
    
    var moonDescription: String {
        switch forecast.moonCode {
        case 0:
            return "Полнолуние"
        case 1...3:
            return "Убывающая Луна"
        case 4:
            return "Последняя четверть"
        case 5...7:
            return "Убывающая Луна"
        case 8:
            return "Новолуние"
        case 9...11:
            return "Растущая Луна"
        case 12:
            return "Первая четверть"
        case 13...15:
            return "Растущая Луна"
            
        default:
            fatalError("Неизвестная фаза луны")
        }
    }
    
    var dayLength: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let sunriseDate = dateFormatter.date(from: forecast.sunrise) else {return ""}
        guard let sunsetDate = dateFormatter.date(from: forecast.sunset) else {return ""}
        
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: sunriseDate, to: sunsetDate)
        let hours = diffComponents.hour!
        let minutes = diffComponents.minute!
        
        return "\(hours):\(minutes)"
    }
    
    var sunrise: String {
        return forecast.sunrise
    }
    
    var sunset: String {
        return forecast.sunset
    }
}
