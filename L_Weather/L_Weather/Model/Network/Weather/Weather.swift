
import Foundation

struct Weather : Codable{
    let fact: Fact
    let forecasts: [Forecast]
}

struct Forecast: Codable {
    let date: String
    
    let week: Int
    
    let sunrise: String
    let sunset: String
    
    let parts: Parts
    let hours: [Hour]
    
    private enum CodingKeys: String, CodingKey {
        case date
        case week
        case sunrise
        case sunset
        case parts
        case hours
    }
}

struct Parts: Codable {
    
    let morning: Morning
    let day: Day
    let evening: Evening
    let night: Night
    
}

struct Morning: Codable {
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case feelsLike = "feels_like"
        case humidity
        case condition
    }
}

struct Day: Codable {
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case feelsLike = "feels_like"
        case humidity
        case condition
    }
}

struct Evening: Codable {
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case feelsLike = "feels_like"
        case humidity
        case condition
    }
}

struct Night: Codable {
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case feelsLike = "feels_like"
        case humidity
        case condition
    }
}
