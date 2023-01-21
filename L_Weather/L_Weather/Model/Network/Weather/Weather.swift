
import Foundation

struct Weather : Codable{
    let fact: Fact
    let forecasts: [Forecast]
}
