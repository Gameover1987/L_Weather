
import Foundation
import CoreLocation

protocol WeatherViewModelProtocol : AnyObject {
    var isReady: Bool {get}
    
    var location: LocationEntity? {get}
    
    var today: TodayWeatherViewModelProtocol? {get}
    
    var hours: [HourViewModelProtocol] {get}
    
    var hourly24: HourlyWeatherViewModelProtocol? {get}
    
    var forecasts: [ForecastViewModelProtocol] {get}
    
    func load(completion: @escaping ((_ result: Result<Weather, Error>) -> Void))
}

final class WeatherViewModel : WeatherViewModelProtocol {
    
    private let weatherApi: WeatherApiProtocol
    private let settingsProvider: SettingsProviderProtocol
    private let factory: WeatherViewModelFactoryProtocol
    
    private let latitude: Double
    private let longtitude: Double
    
    private var weather: Weather?
    
    init (location: LocationEntity, weatherApi: WeatherApiProtocol, settingsProvider: SettingsProviderProtocol, factory: WeatherViewModelFactoryProtocol) {
        self.location = location
        
        self.latitude = location.latitude
        self.longtitude = location.longtitude
        
        self.weatherApi = weatherApi
        self.settingsProvider = settingsProvider
        self.factory = factory
    }
    
    init (coordinate: CLLocationCoordinate2D, weatherApi: WeatherApiProtocol, settingsProvider: SettingsProviderProtocol, factory: WeatherViewModelFactoryProtocol) {
        self.location = nil
        
        self.latitude = coordinate.latitude
        self.longtitude = coordinate.longitude
        
        self.weatherApi = weatherApi
        self.settingsProvider = settingsProvider
        self.factory = factory
    }
    
    var isReady:Bool {
        return weather != nil
    }
    
    let location: LocationEntity?
    
    var today: TodayWeatherViewModelProtocol?
    
    var hours: [HourViewModelProtocol] = []
    
    var hourly24: HourlyWeatherViewModelProtocol?
    
    var forecasts: [ForecastViewModelProtocol] = []
    
    func load(completion: @escaping ((_ result: Result<Weather, Error>) -> Void)) {
        
        weatherApi.performWeatherRequest(lattitude: self.latitude, longtitude: self.longtitude) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(_):
                self.weather = nil
                
            case .success(let weather):
                self.weather = weather
                
                guard let firstForecast = weather.forecasts.first else {return}
                
                self.hours = firstForecast.hours.map { hour in
                    return self.factory.createHourViewModel(by: hour)
                }
                
                self.today = self.factory.createTodayWeatherViewModel(location: self.location, weather: weather)
                
                self.hourly24 = self.factory.createHourlyWeatherViewModel(by: weather)
                
                self.forecasts = weather.forecasts.map { forecast in
                    return self.factory.createForecastViewModel(by: forecast)
                }
            }
            
            completion(result)
        }
    }
}
