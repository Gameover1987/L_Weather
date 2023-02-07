
import XCTest

final class HourViewModelTests : XCTestCase {
    
    func test_ShouldLoadHourViewModel() {
        // Given
        let weather = TestUtils.shared.getWeather()
        
        // When
        let hourViewModel = HourViewModel(by: weather.forecasts.first!.hours.first!, settingsProvider: SettingsProviderMock())
        
        // Then
        XCTAssert(hourViewModel.temp == "-13\u{00B0}")
        XCTAssert(hourViewModel.time == "00:00")
        XCTAssert(hourViewModel.iconName == "ovc_-sn")
    }
}

