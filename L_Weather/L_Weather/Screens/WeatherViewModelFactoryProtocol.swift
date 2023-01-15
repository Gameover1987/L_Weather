
import Foundation

protocol WeatherViewModelFactoryProtocol {
    func createWeatherViewModel(by location: LocationEntity) -> WeatherViewModel
}

final class WeatherViewModelFactory : WeatherViewModelFactoryProtocol {
    static let shared = WeatherViewModelFactory()
    
    private init() { }
    
    func createWeatherViewModel(by location: LocationEntity) -> WeatherViewModel {
        return WeatherViewModel(location: location)
    }
}
