
import Foundation
import CoreLocation

final class WeatherViewModelFactory : WeatherViewModelFactoryProtocol {
    static let shared = WeatherViewModelFactory(settingsProvider: UserDefaultsSettingsProvider.shared)
    
    private let settingsProvider: SettingsProviderProtocol
    
    private init(settingsProvider: SettingsProviderProtocol) {
        self.settingsProvider = settingsProvider
    }
    
    func createWeatherViewModel(by location: LocationEntity) -> WeatherViewModelProtocol {
        return WeatherViewModel(location: location,
                                weatherApi: YandexWeatherApi.shared,
                                settingsProvider: UserDefaultsSettingsProvider.shared,
                                factory: self)
    }
    
    func createWeatherViewModel(coordinate: CLLocationCoordinate2D) -> WeatherViewModelProtocol {
        return WeatherViewModel(coordinate: coordinate,
                                weatherApi: YandexWeatherApi.shared,
                                settingsProvider: UserDefaultsSettingsProvider.shared,
                                factory: self)
    }
    
    func createHourViewModel (by hour: Hour) -> HourViewModelProtocol {
        return HourViewModel(by: hour, settingsProvider: self.settingsProvider)
    }
    
    func createTodayWeatherViewModel(location: LocationEntity?, weather: Weather) -> TodayWeatherViewModelProtocol {
        
        guard let firstForecast = weather.forecasts.first else {fatalError("Прогноз погод не загружен!")}
 
        return TodayWeatherViewModel(location: location, fact: weather.fact, forecast: firstForecast, settingsProvider: settingsProvider)
    }
    
    func createHourlyWeatherViewModel(by weather: Weather) -> HourlyWeatherViewModelProtocol {
        return HourlyWeatherViewModel(weather: weather, settingsProvider: settingsProvider)
    }
    
    func createForecastViewModel(by forecast: Forecast) -> ForecastViewModelProtocol {
        return ForecastViewModel(forecast: forecast, settingsProvider: settingsProvider)
    }
}
