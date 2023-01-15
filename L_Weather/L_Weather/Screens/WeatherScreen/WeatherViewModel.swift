
import Foundation

final class WeatherViewModel {
    
    private let _location: LocationEntity
    
    init (location: LocationEntity) {
        self._location = location
    }
    
    var location: LocationEntity {
        return _location
    }
}
