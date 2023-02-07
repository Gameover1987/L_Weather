
import XCTest
import CoreLocation


final class WeatherViewModelTests: XCTestCase {
    
    func test_ShouldLoadWeather() throws {
        // Given
        let weatherViewModel = WeatherViewModel(coordinate: CLLocationCoordinate2D(),
                                                weatherApi: WeatherApiMock(),
                                                settingsProvider: SettingsProviderMock(),
                                                factory: WeatherViewModelFactoryMock())
        
        var loadedWeather:Weather? = nil
        
        // When
        weatherViewModel.load { result in
            switch result {
            case .success(let weather):
                loadedWeather = weather
                
            default:
                print("Не смогли загрузить погоду")
            }
        }
        
        // Then
        XCTAssert(loadedWeather != nil, "Погода должна быть загружена, любой ценой!!! Блджад!")
    }
}
