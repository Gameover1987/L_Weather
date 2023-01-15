
import Foundation

protocol SettingsProviderProtocol {
    func get() -> Settings
    
    func save(settings: Settings)
    
    func getLocationsPolicy() -> LocationsPolicy?
    
    func setLocationsPolicy(policy: LocationsPolicy)
}
