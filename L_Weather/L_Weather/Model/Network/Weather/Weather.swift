
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


