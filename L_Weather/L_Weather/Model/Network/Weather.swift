
import Foundation

struct Weather : Codable{
    let fact: Fact
    let forecasts: [Forecast]
}

struct Fact: Codable {
    
    let temp: Int
    let feelsLike: Int
    let condition: String
    let icon: String
    let windSpeed: Double
    let windDirection: String
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case icon
        case windSpeed = "wind_speed"
        case windDirection = "wind_dir"
        case pressure = "pressure_mm"
        case humidity
    }
}

struct Forecast: Codable {
    let date: String
    
    let week: Int
    
    let sunrise: String
    let sunset: String
    
    let parts: Parts
    let hours: [Hour]
}

struct Parts: Codable {
    
    let morning: Morning
    let day: Day
    let evening: Evening
    let night: Night
    
}

struct Hour: Codable {
    let hour: String
    let temp: Int
    let feelsLike: Int
    let condition: String
    let cloudness: Double
    let isThunder: Bool
    let windDir: String
    let windSpeed: Double
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case hour = "hour"
        case temp
        case feelsLike = "feels_like"
        case condition
        case cloudness
        case isThunder = "is_thunder"
        case windDir = "wind_dir"
        case windSpeed = "wind_speed"
        case pressure = "pressure_mm"
        case humidity
    }
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
