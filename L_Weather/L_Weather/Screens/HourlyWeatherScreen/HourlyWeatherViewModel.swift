
import Foundation

protocol HourlyWeatherViewModelProtocol : AnyObject {
    
    var hours: [HourDetailsViewModel] {get}
    
    var chart: [HourChartItemViewModel] {get}
}

final class HourlyWeatherViewModel : HourlyWeatherViewModelProtocol {
    
    init(weather: Weather, settingsProvider: SettingsProviderProtocol) {
        
        guard let firstForecast = weather.forecasts.first else {
            hours = []
            chart = []
            return
        }
        
        hours = firstForecast.hours.map { hour in
            return HourDetailsViewModel(date: firstForecast.date.toDate(), hour: hour, settingsProvider: settingsProvider)
        }
        
        chart = firstForecast.hours.map { hour in
            return HourChartItemViewModel(date: firstForecast.date.toDate(), hour: hour, settingsProvider: settingsProvider)
        }
    }
    
    let hours: [HourDetailsViewModel]
    
    let chart: [HourChartItemViewModel]
}
