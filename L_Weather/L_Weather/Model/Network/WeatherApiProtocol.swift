
import Foundation

protocol WeatherApiProtocol {
    func performWeatherRequest(lattitude: Double, longtitude: Double, completion: @escaping (Result<Weather, Error>) -> Void)
}


