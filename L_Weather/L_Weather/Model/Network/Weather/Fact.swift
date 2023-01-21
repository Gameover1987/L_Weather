
import Foundation

struct Fact: Codable {
    
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

extension Fact {
    
}
