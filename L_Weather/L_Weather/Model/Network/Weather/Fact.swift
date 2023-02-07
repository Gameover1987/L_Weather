
import Foundation

struct Fact: Codable {
    
    init() {
        self.obsTime = 0
        self.temp = 0
        self.feelsLike = 0
        self.condition = ""
        self.icon = ""
        self.windSpeed = 0.0
        self.windDirection = ""
        self.pressure = 0
        self.humidity = 0
        self.cloudness = 0.0
        self.season = "summer"
    }
    
    let obsTime: Int
    let temp: Int
    let feelsLike: Int
    let condition: String
    let icon: String
    let windSpeed: Double
    let windDirection: String
    let pressure: Int
    let humidity: Int
    let cloudness: Double
    let season: String
    
    private enum CodingKeys: String, CodingKey {
        case obsTime = "obs_time"
        case temp
        case feelsLike = "feels_like"
        case condition
        case icon
        case windSpeed = "wind_speed"
        case windDirection = "wind_dir"
        case pressure = "pressure_mm"
        case humidity
        case cloudness
        case season
    }
}
