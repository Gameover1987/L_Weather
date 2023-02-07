
import Foundation

final class TestUtils : NSObject {
    
    static let shared = TestUtils()
    
    private override init() {
        
    }
    
    func getWeather() -> Weather {
        let decoder = JSONDecoder()
        let url = Bundle(for: type(of: self)).url(forResource: "Weather", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        let weather = try? decoder.decode(Weather.self, from: data!)
        return weather!
    }
}
