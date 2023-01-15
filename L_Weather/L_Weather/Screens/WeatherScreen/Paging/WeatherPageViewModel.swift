
import Foundation

final class WeatherPageViewModel {
    
    private let locationsProvider: LocationsProviderProtocol
    private let weatherViewModelFactory: WeatherViewModelFactoryProtocol
    private let locationGeocoder: LocationGeocoderProtocol
      
    init (locationsProvider: LocationsProviderProtocol,
          weatherViewModelFactory: WeatherViewModelFactoryProtocol,
          locationGeocoder: LocationGeocoderProtocol) {
        self.locationsProvider = locationsProvider
        self.weatherViewModelFactory = weatherViewModelFactory
        self.locationGeocoder = locationGeocoder
        
        self.weatherByLocations = locationsProvider.locations.map({ location in
            return self.weatherViewModelFactory.createWeatherViewModel(by: location)
        })
    }
    
    var weatherByLocations: [WeatherViewModel] = []
    
    var locationAddedHandler: ((_ weatherViewModel: WeatherViewModel) -> Void)?
    
    func addLocation(locationName: String) {
        locationGeocoder.decodeLocation(by: locationName) { [weak self] location in
            
            guard let self = self else {return}
            guard let location = location else { return }
            
            let existedLocations = self.weatherByLocations.map { weatherViewModel in
                return weatherViewModel.location
            }
            
            if existedLocations.contains(where: { storedLocation in
                return storedLocation.longtitude == location.coordinate.longitude &&
                       storedLocation.latitude == location.coordinate.latitude
            }) {
                return
            }
            
            let locationEntity = self.locationsProvider.addLocation(name: locationName, latitude: location.coordinate.latitude, longtitude: location.coordinate.longitude)
            let weatherViewModel = self.weatherViewModelFactory.createWeatherViewModel(by: locationEntity)
            self.weatherByLocations.append(weatherViewModel)
            
            self.locationAddedHandler?(weatherViewModel)
        }
    }
}
