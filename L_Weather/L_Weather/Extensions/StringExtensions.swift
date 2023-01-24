
import Foundation

extension String? {
    func isNullOrWhiteSpace() -> Bool {
        if self == nil {
            return true
        }
        
        return self == ""
        
    }
}

extension String {
    
    func isNullOrWhiteSpace() -> Bool {
        return self == ""
    }
    
    /// Возвращает локализованное условие погоды
    func toWeatherConditionLocalized() -> String {
        
        switch self {
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
            fatalError("Строка представляет неизвестное условие погоды")
        }
    }
    
    func toWindDirectionLocalized() -> String {
        switch self {
        case "nw":
            return "СЗ"
            
        case "n":
            return "С"
            
        case "ne":
            return "СВ"
            
        case "e":
            return "В"
            
        case "se":
            return "ЮВ"
            
        case "s":
            return "Ю"
            
        case "sw":
            return "ЮЗ"
            
        case "w":
            return "З"
            
        case "с":
            return "штиль"
            
        default:
            fatalError("Строка представляет")
        }
    }
    
    func toDate(_ format: String? = nil) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "yyyy-MM-dd"
        
        return dateFormatter.date(from: self)!
    }
}

