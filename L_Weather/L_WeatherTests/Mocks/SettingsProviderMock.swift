
import Foundation

final class SettingsProviderMock : SettingsProviderProtocol {
    func get() -> Settings {
        return Settings(tempDisplayMode: .celsius, windSpeedDisplayMode: .kilometers, timeFormat: .hours24, isNotificationsEnabled: false)
    }
    
    func save(settings: Settings) {
        
    }
    
    func getLocationsPolicy() -> LocationsPolicy? {
        fatalError("\(#function) is not implemented")
    }
    
    func setLocationsPolicy(policy: LocationsPolicy) {
        fatalError("\(#function) is not implemented")
    }
}
