
import Foundation
import CoreLocation

final class WeatherViewModelFactoryMock : WeatherViewModelFactoryProtocol {
    func createWeatherViewModel(by location: LocationEntity) -> WeatherViewModelProtocol {
       return WeatherViewModel(location: location, weatherApi: WeatherApiMock(), settingsProvider: SettingsProviderMock(), factory: self)
    }
    
    func createWeatherViewModel(coordinate: CLLocationCoordinate2D) -> WeatherViewModelProtocol {
        return WeatherViewModel(coordinate: coordinate, weatherApi: WeatherApiMock(), settingsProvider: SettingsProviderMock(), factory: self)
    }
    
    func createHourViewModel(by hour: Hour) -> HourViewModelProtocol {
       return HourViewModel(by: hour, settingsProvider: SettingsProviderMock())
    }
    
    func createTodayWeatherViewModel(location: LocationEntity?, weather: Weather) -> TodayWeatherViewModelProtocol {
        return TodayWeatherViewModel(location: location,
                                     fact: weather.fact,
                                     forecast: weather.forecasts.first!,
                                     settingsProvider: SettingsProviderMock())
    }
    
    func createHourlyWeatherViewModel(by weather: Weather) -> HourlyWeatherViewModelProtocol {
       return HourlyWeatherViewModel(weather: weather, settingsProvider: SettingsProviderMock())
    }
    
    func createForecastViewModel(by forecast: Forecast) -> ForecastViewModelProtocol {
       return ForecastViewModel(forecast: forecast, settingsProvider: SettingsProviderMock())
    }
}
