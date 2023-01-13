
import Foundation

protocol SettingsProviderProtocol {
    func get() -> Settings
    
    func save(settings: Settings)
}
