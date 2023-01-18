
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
        
        return "\(weather.fact.temp.toFahrengeit())\u{00B0}"
    }
    
    func getWindSpeed() -> String {
        
        guard let weather = weather else {return ""}
        
        let settings = settingsProvider.get()
        
        if (settings.windSpeedDisplayMode == .kilometers) {
            return "\(String(format: "%.1f", weather.fact.windSpeed)) m\\s"
        }
        
        return "\(String(format: "%.1f", weather.fact.windSpeed.toMilesPerHour())) mi\\h"
    }
    
    func getCurrentDateAndTime() -> String {
        let settings = settingsProvider.get()
        
        let forecastDate = Date()
        
        let dateFormatter = DateFormatter()
        if (settings.timeFormat == .hours12) {
            dateFormatter.dateFormat = "hh:mm, d MMMM"
        } else {
            dateFormatter.dateFormat = "HH:mm, d MMMM"
        }
        
        return dateFormatter.string(from: forecastDate)
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
        if let todayForecast = weather?.forecasts.first {
            return todayForecast.sunrise
        }
        
        return ""
    }
    
    func getSunset() -> String {
        if let todayForecast = weather?.forecasts.first {
            return todayForecast.sunset
        }
        
        return ""
    }
}
