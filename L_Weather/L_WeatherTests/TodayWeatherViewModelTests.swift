
import XCTest

final class TodayWeatherViewModelTests : XCTestCase {
    func test_ShouldLoadTodayForecast() {
        // Given
        let weather = TestUtils.shared.getWeather()
        
        // When
        let todayWeatherViewModel = TodayWeatherViewModel(location: nil,
                                                          fact: weather.fact,
                                                          forecast: weather.forecasts.first!,
                                                          settingsProvider: SettingsProviderMock())
        
        // Then
        XCTAssert(todayWeatherViewModel.temp == "-15\u{00B0}")
        XCTAssert(todayWeatherViewModel.cloudness == "100 %")
        XCTAssert(todayWeatherViewModel.conditionDescription == "Пасмурно")
        XCTAssert(todayWeatherViewModel.condtionIcon == "ovc")
        XCTAssert(todayWeatherViewModel.forecastDate == "23:00, 7 февраля")
        XCTAssert(todayWeatherViewModel.humidity == "76%")
        XCTAssert(todayWeatherViewModel.locationDescription == "Текущее местоположение")
        XCTAssert(todayWeatherViewModel.sunrise == "09:08")
        XCTAssert(todayWeatherViewModel.sunset == "18:15")
        XCTAssert(todayWeatherViewModel.tempRange == "-15° -11°")
        XCTAssert(todayWeatherViewModel.windSpeed == "1 m\\s")
    }
}
