
import Foundation

struct Parts: Codable {
    
    let morning: Morning
    let day: Day
    let evening: Evening
    let night: Night
    
}

protocol PartOfDayProtocol {
    var name: String {get}
    var tempMin: Int {get}
    var tempMax: Int {get}
    var tempAvg: Int {get}
    var windSpeed: Double {get}
    var windDir: String {get}
    var cloudness: Double {get}
    var icon: String {get}
    var feelsLike: Int {get}
    var pressure: Int {get}
    var humidity: Int {get}
    var condition: String {get}
    var uvIndex: Int? {get}
    var precProb: Double {get}
}

struct Morning: Codable, PartOfDayProtocol {
    
    var name: String {
        return "Утро"
    }
    
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let icon: String
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    let uvIndex: Int?
    let precProb: Double
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case icon
        case feelsLike = "feels_like"
        case humidity
        case condition
        case uvIndex = "uv_index"
        case precProb = "prec_prob"
    }
}

struct Day: Codable, PartOfDayProtocol {
    
    var name: String {
        return "День"
    }
    
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let icon: String
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    let uvIndex: Int?
    let precProb: Double
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case icon
        case feelsLike = "feels_like"
        case humidity
        case condition
        case uvIndex = "uv_index"
        case precProb = "prec_prob"
    }
}

struct Evening: Codable, PartOfDayProtocol {
    
    var name: String {
        return "Вечер"
    }
    
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let icon: String
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    let uvIndex: Int?
    let precProb: Double
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case icon
        case feelsLike = "feels_like"
        case humidity
        case condition
        case uvIndex = "uv_index"
        case precProb = "prec_prob"
    }
}

struct Night: Codable, PartOfDayProtocol {
  
    var name: String {
        return "Ночь"
    }
    
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let windSpeed: Double
    let windDir: String
    let cloudness: Double
    let icon: String
    let feelsLike: Int
    let pressure: Int
    let humidity: Int
    let condition: String
    let uvIndex: Int?
    let precProb: Double
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressure = "pressure_mm"
        case cloudness
        case icon
        case feelsLike = "feels_like"
        case humidity
        case condition
        case uvIndex = "uv_index"
        case precProb = "prec_prob"
    }
}
