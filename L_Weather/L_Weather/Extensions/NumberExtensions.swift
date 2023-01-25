
import Foundation

extension Double {
    
    /// Конвертирует скорость из метров в секунду в мили в час
    func toMilesPerHour() -> Double {
        let kmToMileRatio = 2.23694
        
        return self * kmToMileRatio
    }
}

extension Int {
    
    /// Конвертирует градусы по Цельсию в градусы по Фаренгейту
    func toFahrengeit() -> Double {
        return (Double(self) * (9/5)) + 32.0
    }
    
    func toDate() -> Date {
        let date = Date(timeIntervalSince1970: Double(self))
        return date
    }
}
