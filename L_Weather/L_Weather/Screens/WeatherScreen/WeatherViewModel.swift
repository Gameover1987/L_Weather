
import Foundation

final class WeatherViewModel {
    
    private let _location: LocationEntity
    private let weatherApi: WeatherApiProtocol
    
    init (location: LocationEntity, weatherApi: WeatherApiProtocol) {
        self._location = location
        self.weatherApi = weatherApi
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
}
