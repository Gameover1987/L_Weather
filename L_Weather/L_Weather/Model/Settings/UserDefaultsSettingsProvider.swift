
import Foundation

final class UserDefaultsSettingsProvider: SettingsProviderProtocol {

    private let settingsKey = "Settings"
    
    static let shared = UserDefaultsSettingsProvider()
    
    private init () {
        
    }
    
    func get() -> Settings {
        guard let settingsJson = UserDefaults.standard.string(forKey: settingsKey) else {
            return Settings(tempDisplayMode: .celsius, windSpeedDisplayMode: .kilometers , timeFormat: .hours24, isNotificationsEnabled: false)
        }
        
        let settings = try! JSONDecoder().decode(Settings.self, from: settingsJson.data(using: .utf8)!)
        return settings
    }
    
    func save(settings: Settings) {
        let settingsData = try! JSONEncoder().encode(settings)
        
        let settingsJson = String(decoding: settingsData, as: UTF8.self)
        
        UserDefaults.standard.set(settingsJson, forKey: settingsKey)
        UserDefaults.standard.synchronize()
    }
}
