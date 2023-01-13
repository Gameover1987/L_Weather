
import Foundation

final class SettingsViewModel {
    
    private let settingsProvider: SettingsProviderProtocol
    private var currentSettings: Settings
    
    init (settingsProvider: SettingsProviderProtocol) {
        self.settingsProvider = settingsProvider
        
        self.currentSettings = settingsProvider.get()
    }
    
    var tempDisplayMode: TempDisplayMode {
        get {
            return currentSettings.tempDisplayMode
        }
        set {
            currentSettings.tempDisplayMode = newValue
        }
    }
    
    var windSpeedDisplayMode: WindSpeedDisplayMode {
        get {
            return currentSettings.windSpeedDisplayMode
        }
        set {
            currentSettings.windSpeedDisplayMode = newValue
        }
    }
    
    var timeFormat: TimeFormat {
        get {
            return currentSettings.timeFormat
        }
        set {
            currentSettings.timeFormat = newValue
        }
    }
    
    var isNotificationsEnabled: Bool {
        get {
            return currentSettings.isNotificationsEnabled
        }
        set {
            currentSettings.isNotificationsEnabled = newValue
        }
    }
    
    func save() {
        settingsProvider.save(settings: currentSettings)
    }
}
