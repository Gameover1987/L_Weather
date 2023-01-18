
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
    var locationRemovedHandler: ((_ weatherViewModel: WeatherViewModel) -> Void)?
    
    func addLocation(locationName: String) {
        locationGeocoder.decodeLocation(by: locationName) { [weak self] placemark in
            
            guard let self = self else {return}
            guard let placemark = placemark else { return }
            guard let location = placemark.location else { return }
            
            let existedLocations = self.weatherByLocations.map { weatherViewModel in
                return weatherViewModel.location
            }
            
            if existedLocations.contains(where: { storedLocation in
                return storedLocation.longtitude == location.coordinate.longitude &&
                       storedLocation.latitude == location.coordinate.latitude
            }) {
                return
            }
            
            if placemark.locality?.isNullOrWhiteSpace() == true ||
                placemark.country?.isNullOrWhiteSpace() == true {
                return
            }
            
            let locationEntity = self.locationsProvider.addLocation(name: placemark.locality!,
                                                                    country: placemark.country!,
                                                                    latitude: location.coordinate.latitude,
                                                                    longtitude: location.coordinate.longitude)
            let weatherViewModel = self.weatherViewModelFactory.createWeatherViewModel(by: locationEntity)
            self.weatherByLocations.append(weatherViewModel)
            
            self.locationAddedHandler?(weatherViewModel)
        }
    }
    
    func removeLocation(weatherViewModel: WeatherViewModel) {
        weatherByLocations.removeAll { viewModel in
            viewModel === weatherViewModel
        }
        
        locationsProvider.removeLocation(location: weatherViewModel.location)
        
        self.locationRemovedHandler?(weatherViewModel)
    }
}
