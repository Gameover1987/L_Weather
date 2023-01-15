
import Foundation

enum TempDisplayMode : String, Codable {
    case celsius = "C"
    case fahrengeit = "F"
    
    func index() -> Int {
        if self == .celsius {
            return 0
        }
        
        return 1
    }
    
    static func from(index: Int) -> TempDisplayMode {
        if index == 0 {
            return .celsius
        }
            
        return .fahrengeit
    }
}

enum WindSpeedDisplayMode : String, Codable {
    case miles = "Mi"
    case kilometers = "Km"
    
    func index() -> Int {
        if self == .miles {
            return 0
        }
        
        return 1
    }
    
    static func from(index: Int) -> WindSpeedDisplayMode {
        if index == 0 {
            return .miles
        }
            
        return .kilometers
    }
}

enum TimeFormat: String, Codable {
    case hours12 = "12"
    case hours24 = "24"
    
    func index() -> Int {
        if self == .hours12 {
            return 0
        }
        
        return 1
    }
    
    static func from(index: Int) -> TimeFormat {
        if index == 0 {
            return .hours12
        }
            
        return .hours24
    }
}

struct Settings : Codable {
    var tempDisplayMode: TempDisplayMode
    var windSpeedDisplayMode: WindSpeedDisplayMode
    var timeFormat: TimeFormat
    var isNotificationsEnabled: Bool
}

enum LocationsPolicy : String, Codable {
    
    case automatic
    case manual
    
    static func from(string: String) -> LocationsPolicy {
        if string == LocationsPolicy.automatic.rawValue {
            return .automatic
        }
        
        return .manual
    }
}
