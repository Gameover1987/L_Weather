
import Foundation

protocol TodayWeatherViewModelProtocol {
    
    var locationDescription: String {get}
    
    var tempRange: String {get}
    
    var temp: String {get}
    
    var cloudness: String {get}
    
    var windSpeed: String {get}
    
    var forecastDate: String {get}
    
    var condtionIcon: String {get}
    
    var conditionDescription: String {get}
    
    var humidity: String {get}
    
    var sunrise: String {get}
    
    var sunset: String {get}
}

final class TodayWeatherViewModel : TodayWeatherViewModelProtocol {
    private let location: LocationEntity?
    private let fact: Fact
    private let forecast: Forecast
    private let settingsProvider: SettingsProviderProtocol
    
    init (location: LocationEntity?, fact: Fact, forecast: Forecast, settingsProvider: SettingsProviderProtocol) {
        self.location = location
        self.fact = fact
        self.forecast = forecast
        self.settingsProvider = settingsProvider
    }
    
    var locationDescription: String {
        guard let location = location else {
            return "Текущее местоположение"
        }
        
        return location.locationDescription
    }
    
    var tempRange: String {
        guard let minTemp = forecast.hours.max(by: { hourA, hourB in
            return hourA.temp > hourB.temp
        })?.temp else {return ""}
        
        guard let maxTemp = forecast.hours.max(by: { hourA, hourB in
            return hourA.temp < hourB.temp
        })?.temp else {return ""}
        
        let settings = settingsProvider.get()
        var tempRangeStr = ""
        if settings.tempDisplayMode == .celsius {
            tempRangeStr = "\(minTemp)\u{00B0} \(maxTemp)\u{00B0}"
        } else {
            tempRangeStr = "\(Int(forecast.parts.day.tempMin.toFahrengeit()))\u{00B0} \(Int(forecast.parts.day.tempMax.toFahrengeit()))\u{00B0}"
        }
        
        return tempRangeStr
    }
    
    var temp: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTempAsString(fact.temp, displayMode: settings.tempDisplayMode)
    }
    
    var cloudness: String {
        return WeatherDisplayHelper.getCloudnessAsString(fact.cloudness)
    }
    
    var windSpeed: String {
        let settings = settingsProvider.get()
        let windSpeed = WeatherDisplayHelper.getWindSpeedAsString(fact.windSpeed, displayMode: settings.windSpeedDisplayMode)
        return windSpeed
    }
    
    var forecastDate: String {
        let settings = settingsProvider.get()
        let forecastdate = getDateAndTimeAsString(date: fact.obsTime.toDate(), format: settings.timeFormat)
        return forecastdate
    }
    
    var condtionIcon: String {
        return fact.icon
    }
    
    var conditionDescription: String {
        let description = fact.condition.toWeatherConditionLocalized()
        return description
    }
    
    var humidity: String {
        return String(fact.humidity)+"%"
    }
    
    var sunrise: String {
        let settings = settingsProvider.get()
        
        let date = forecast.sunrise.toDate("HH:mm")
        
        return WeatherDisplayHelper.getTimeAsString(date: date, timeFormat: settings.timeFormat)
    }
    
    var sunset: String {
        let settings = settingsProvider.get()
        
        let date = forecast.sunset.toDate("HH:mm")
        
        return WeatherDisplayHelper.getTimeAsString(date: date, timeFormat: settings.timeFormat)
    }
    
    private func getDateAndTimeAsString(date: Date, format: TimeFormat) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU")
        if (format == .hours12) {
            dateFormatter.dateFormat = "h:mm a, d MMMM"
        } else {
            dateFormatter.dateFormat = "HH:mm, d MMMM"
        }
        
        return dateFormatter.string(from: date)
    }
}
