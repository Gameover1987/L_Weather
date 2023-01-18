
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
    }
}

extension Fact {
    /// Возвращает локализованное условие погоды
    func conditionLocalized() -> String {
        switch self.condition {
        case "clear":
            return "Ясно"
            
        case "partly-cloudy":
            return "Малооблачно"
            
        case "cloudy":
            return "Облачно с прояснениями"
            
        case "overcast":
            return "Пасмурно"
            
        case "drizzle":
            return "Морось"
            
        case "light-rain":
            return "Небольшой дождь"
            
        case "rain":
            return "Дождь"
            
        case "moderate-rain":
            return "Умеренно сильный дождь"
            
        case "heavy-rain":
            return "Сильный дождь"
            
        case "continuous-heavy-rain":
            return "Длительный сильный дождь"
            
        case "showers":
            return "Ливень"
            
        case "wet-snow":
            return "Дождь со сгнегом"
            
        case "light-snow":
            return "Небольшой снег"
            
        case "snow":
            return "Снег"
            
        case "snow-showers":
            return "Снегопад"
            
        case "hail":
            return "Град"
            
        case "thunderstorm":
            return "Гроза"
            
        case "thunderstorm-with-rain":
            return "Дождь с грозой"
            
        case "thunderstorm-with-hail":
            return "Гроза с градом"
            
        default:
            fatalError("Неизвестное условие погоды")
        }
    }
}
