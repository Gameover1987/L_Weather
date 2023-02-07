
import Foundation

struct Weather : Codable{
    
    init() {
        self.fact = Fact()
    }
    
    var fact: Fact
    var forecasts: [Forecast] = []
}
