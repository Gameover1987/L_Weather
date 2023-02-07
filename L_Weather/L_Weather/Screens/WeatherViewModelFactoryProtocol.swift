
import Foundation
import CoreLocation

protocol WeatherViewModelFactoryProtocol {
    
    func createWeatherViewModel(by location: LocationEntity) -> WeatherViewModelProtocol
    
    func createWeatherViewModel(coordinate: CLLocationCoordinate2D) -> WeatherViewModelProtocol
    
    func createHourViewModel (by hour: Hour) -> HourViewModelProtocol
    
    func createTodayWeatherViewModel(location: LocationEntity?, weather: Weather) -> TodayWeatherViewModelProtocol
    
    func createHourlyWeatherViewModel(by weather: Weather) -> HourlyWeatherViewModelProtocol
    
    func createForecastViewModel(by forecast: Forecast) -> ForecastViewModelProtocol
}
