
import Foundation

final class WeatherViewModel {
    
    private let _location: LocationEntity
    private let weatherApi: WeatherApiProtocol
    private let settingsProvider: SettingsProviderProtocol
    
    init (location: LocationEntity, weatherApi: WeatherApiProtocol, settingsProvider: SettingsProviderProtocol) {
        self._location = location
        self.weatherApi = weatherApi
        self.settingsProvider = settingsProvider
    }
    
    var location: LocationEntity {
        return _location
    }
    
    var weather: Weather?
    
    func load(completion: @escaping ((_ result: Result<Weather, Error>) -> Void)) {
        
        weatherApi.performWeatherRequest(lattitude: location.latitude, longtitude: location.longtitude) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(_):
                self.weather = nil
                
            case .success(let weather):
                self.weather = weather
            }
            
            completion(result)
        }
    }
    
    func getTemp() -> String {
        
        guard let weather = weather else {return ""}
        
        let settings = settingsProvider.get()
        
        if (settings.tempDisplayMode == .celsius) {
            return "\(weather.fact.temp)\u{00B0}"
        }
        
        let tempInFahrenheit = weather.fact.temp.toFahrengeit()
        return "\(Int(tempInFahrenheit))\u{00B0}"
    }
    
    func getCloudness() -> String {
        guard let weather = weather else {return ""}
        
        return String(format: "%0.f", weather.fact.cloudness * 100) + " %"
    }
    
    func getWindSpeed() -> String {
        
        guard let weather = weather else {return ""}
        
        let settings = settingsProvider.get()
        
        if (settings.windSpeedDisplayMode == .kilometers) {
            return "\(String(format: "%.0f", weather.fact.windSpeed)) m\\s"
        }
        
        return "\(String(format: "%.0f", weather.fact.windSpeed.toMilesPerHour())) mi\\h"
    }
    
    func getCurrentDateAndTime() -> String {
        let settings = settingsProvider.get()
        
        let forecastDate = Date()
        
        return getDateAndTimeAsString(date: forecastDate, format: settings.timeFormat)
    }
    
    func getWeatherConditionIcon() -> String {
        guard let weather = weather else {return ""}
        
        return weather.fact.icon
    }
    
    func getWeatherConditionLocalized() -> String {
        guard let weather = weather else {return ""}
        
        return weather.fact.conditionLocalized()
    }
    
    func getHumidity() -> String {
        guard let weather = weather else {return ""}
        
        return String(weather.fact.humidity)+"%"
    }
    
    func getSunrise() -> String {
        
        let settings = settingsProvider.get()
        
        if let todayForecast = weather?.forecasts.first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            guard let date = dateFormatter.date(from: todayForecast.sunrise) else {return ""}
            
            return getTimeAsString(date: date, format: settings.timeFormat)
        }
        
        return ""
    }
    
    func getSunset() -> String {
        
        let settings = settingsProvider.get()
        
        if let todayForecast = weather?.forecasts.first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            guard let date = dateFormatter.date(from: todayForecast.sunset) else {return ""}
            
            return getTimeAsString(date: date, format: settings.timeFormat)
        }
        
        return ""
    }
    
    private func getDateAndTimeAsString(date: Date, format: TimeFormat) -> String {
        
        let dateFormatter = DateFormatter()
        if (format == .hours12) {
            dateFormatter.dateFormat = "hh:mm, d MMMM"
        } else {
            dateFormatter.dateFormat = "HH:mm, d MMMM"
        }
        
        return dateFormatter.string(from: date)
    }
    
    private func getTimeAsString(date: Date, format: TimeFormat) -> String {
        let dateFormatter = DateFormatter()
        if (format == .hours12) {
            dateFormatter.dateFormat = "hh:mm"
        } else {
            dateFormatter.dateFormat = "HH:mm"
        }
        
        return dateFormatter.string(from: date)
    }
}
