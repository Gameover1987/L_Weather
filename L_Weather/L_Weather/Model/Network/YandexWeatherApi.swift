
import Foundation

enum ApiErrors : String, Error {
    case dataIsNil = "Data is nil!"
    case jsonParseError = "JSON parse error"
}

final class YandexWeatherApi : WeatherApiProtocol {
    private let scheme = "https"
    private let host = "api.weather.yandex.ru"
    private let path = "/v2/forecast"
    private let apiKeyHeader = "X-Yandex-API-Key"
    private let apiKey = "200d9001-e093-44c8-8ed4-5d3ef6903638"
    
    static let shared = YandexWeatherApi()
    
    private init() {
        
    }
    
    func performWeatherRequest(lattitude: Double, longtitude: Double, completion: @escaping (Result<Weather, Error>) -> Void) {
        
        let request = getWeatherApiRequest(lattitude, longtitude)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiErrors.dataIsNil))
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Weather.self, from: data)
                completion(.success(weather))
            }
            catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func getWeatherApiRequest(_ lattitude: Double, _ longtitude: Double) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lattitude)),
            URLQueryItem(name: "lon", value: String(longtitude))
        ]
        
        guard let url = urlComponents.url else {
            fatalError("Error creating Yandex.Weather.API url from components")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = [apiKeyHeader: apiKey]
        
        return urlRequest
    }
    
    
}
