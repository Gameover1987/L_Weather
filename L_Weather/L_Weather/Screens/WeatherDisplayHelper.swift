
import Foundation

final class WeatherDisplayHelper {
    
    static func getTimeAsString(date: Date, timeFormat: TimeFormat) -> String {
        return getTimeAsString(date: date, hourNumber: 0, timeFormat: timeFormat)
    }
    
    static func getTimeAsString(date: Date, hourNumber: Int, timeFormat: TimeFormat) -> String {
        let dateWithHour = Calendar.current.date(byAdding: .hour, value: hourNumber, to: date)!

        if timeFormat == .hours12 {
            return dateWithHour.toString(format: "h:mm a")
        }

        return dateWithHour.toString(format: "HH:mm")
    }
    
    static func getTimeFromUnixFormatAsString(unixDate: Double, format: TimeFormat) -> String {
        let date = Date(timeIntervalSince1970: unixDate)
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format == .hours12 ? "h:mm a" : "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    static func getTemp(_ temp: Int, displayMode: TempDisplayMode) -> Int {
        return displayMode == .celsius ? Int(temp) : Int(temp.toFahrengeit())
    }
    
    static func getTempAsString(_ temp: Int, displayMode: TempDisplayMode) -> String {
        return "\(getTemp(temp, displayMode: displayMode))\u{00B0}"
    }
    
    static func getCloudnessAsString(_ cloudness: Double) -> String {
        
        return String(format: "%0.f", cloudness * 100) + " %"
    }
    
    static func getWindSpeedAsString(_ windSpeed: Double, displayMode: WindSpeedDisplayMode) -> String {
        
        if (displayMode == .kilometers) {
            return "\(String(format: "%.0f", windSpeed)) m\\s"
        }
        
        return "\(String(format: "%.0f", windSpeed.toMilesPerHour())) mi\\h"
    }
}
