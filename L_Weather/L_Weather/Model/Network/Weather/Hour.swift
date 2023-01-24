
import Foundation

struct Hour: Codable {
    let hour: String
    let hourTs: Double
    let temp: Int
    let feelsLike: Int
    let condition: String
    let cloudness: Double
    let icon: String
    let isThunder: Bool
    let windDir: String
    let windSpeed: Double
    let pressure: Int
    let humidity: Int
    let precProb: Double
    
    private enum CodingKeys: String, CodingKey {
        case hour = "hour"
        case hourTs = "hour_ts"
        case temp
        case feelsLike = "feels_like"
        case condition
        case cloudness
        case icon
        case isThunder = "is_thunder"
        case windDir = "wind_dir"
        case windSpeed = "wind_speed"
        case pressure = "pressure_mm"
        case humidity
        case precProb = "prec_prob"
    }
}
