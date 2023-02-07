
import Foundation

final class WeatherApiMock : WeatherApiProtocol {
    
    private var weather: Weather!
   
    init() {
        self.weather = TestUtils.shared.getWeather()
    }
    
    func performWeatherRequest(lattitude: Double, longtitude: Double, completion: @escaping (Result<Weather, Error>) -> Void) {
        completion(Result.success(self.weather))
    }
}
