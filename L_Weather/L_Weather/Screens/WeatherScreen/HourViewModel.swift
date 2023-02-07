
import Foundation

protocol HourViewModelProtocol : AnyObject {
    
    var time: String {get}
    
    var iconName: String {get}
    
    var temp: String {get}
}

final class HourViewModel : HourViewModelProtocol {
    
    private let settingsProvider: SettingsProviderProtocol
    private let hour: Hour
    
    init (by hour: Hour, settingsProvider: SettingsProviderProtocol) {
        self.settingsProvider = settingsProvider
        self.hour = hour
    }
    
    var time: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTimeFromUnixFormatAsString(unixDate: hour.hourTs, format: settings.timeFormat)
    }
    
    var iconName: String {
        return hour.icon
    }
    
    var temp: String {
        let settings = settingsProvider.get()
        return WeatherDisplayHelper.getTempAsString(hour.temp, displayMode: settings.tempDisplayMode)
    }
}
