
import Foundation
import CoreLocation

protocol WeatherViewModelFactoryProtocol {
    func createWeatherViewModel(by location: LocationEntity) -> WeatherViewModel
    
    func createWeatherViewModel(coordinate: CLLocationCoordinate2D) -> WeatherViewModel
    
    func createHourViewModel (by hour: Hour) -> HourViewModel
    
    func createTodayWeatherViewModel(location: LocationEntity?, weather: Weather) -> TodayWeatherViewModel
    
    func createHourlyWeatherViewModel(by weather: Weather) -> HourlyWeatherViewModel
    
    func createForecastViewModel(by forecast: Forecast) -> ForecastViewModel
}

final class WeatherViewModelFactory : WeatherViewModelFactoryProtocol {
    static let shared = WeatherViewModelFactory(settingsProvider: UserDefaultsSettingsProvider.shared)
    
    private let settingsProvider: SettingsProviderProtocol
    
    private init(settingsProvider: SettingsProviderProtocol) {
        self.settingsProvider = settingsProvider
    }
    
    func createWeatherViewModel(by location: LocationEntity) -> WeatherViewModel {
        return WeatherViewModel(location: location,
                                weatherApi: YandexWeatherApi.shared,
                                settingsProvider: UserDefaultsSettingsProvider.shared,
                                factory: self)
    }
    
    func createWeatherViewModel(coordinate: CLLocationCoordinate2D) -> WeatherViewModel {
        return WeatherViewModel(coordinate: coordinate,
                                weatherApi: YandexWeatherApi.shared,
                                settingsProvider: UserDefaultsSettingsProvider.shared,
                                factory: self)
    }
    
    func createHourViewModel (by hour: Hour) -> HourViewModel {
        return HourViewModel(by: hour, settingsProvider: self.settingsProvider)
    }
    
    func createTodayWeatherViewModel(location: LocationEntity?, weather: Weather) -> TodayWeatherViewModel {
        
        guard let firstForecast = weather.forecasts.first else {fatalError("Прогноз погод не загружен!")}
 
        return TodayWeatherViewModel(location: location, fact: weather.fact, forecast: firstForecast, settingsProvider: settingsProvider)
    }
    
    func createHourlyWeatherViewModel(by weather: Weather) -> HourlyWeatherViewModel {
        return HourlyWeatherViewModel(weather: weather, settingsProvider: settingsProvider)
    }
    
    func createForecastViewModel(by forecast: Forecast) -> ForecastViewModel {
        return ForecastViewModel(forecast: forecast, settingsProvider: settingsProvider)
    }
}
