
import UIKit
import SnapKit

final class TodayWeatherTableViewCell : UITableViewCell {
    
    static let identifier = "TodayWeather"
    
    private lazy var panel: UIView = {
        let panel = UIView()
        panel.backgroundColor = Colors.Weather.todayPanelBacground
        panel.layer.cornerRadius = 5
        return panel
    }()
    
    private lazy var ellipseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse")!
        return imageView
    }()
    
    private lazy var sunriseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunrise")
        return imageView
    }()
    
    private lazy var sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium14
        label.textColor = .white
        return label
    }()
    
    private lazy var sunsetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunset")
        return imageView
    }()
    
    private lazy var sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium14
        label.textColor = .white
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium36
        label.textColor = .white
        return label
    }()
    
    private lazy var weatherConditionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        label.textColor = .white
        return label
    }()
    
    private lazy var windSpeedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WindSpeed")
        return imageView
    }()
    
    private lazy var windSpeedILabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = .white
        return label
    }()
    
    private lazy var humidityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Humidity")
        return imageView
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = .white
        return label
    }()
    
    private lazy var weatherConditionImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        label.textColor = Colors.Weather.dateAndTimeColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(panel)
        panel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.right.equalTo(contentView).inset(-32)
            make.height.equalTo(212)
        }
        
        addSubview(ellipseImage)
        ellipseImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(17)
            make.left.equalTo(contentView).inset(49)
            make.right.equalTo(contentView).inset(17)
        }
        
        addSubview(sunriseImage)
        sunriseImage.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(42)
            make.top.equalTo(contentView).inset(145)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        addSubview(sunriseTimeLabel)
        sunriseTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(33)
            make.top.equalTo(contentView).inset(167)
        }
        
        addSubview(sunsetImage)
        sunsetImage.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(10)
            make.top.equalTo(contentView).inset(145)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        addSubview(sunsetTimeLabel)
        sunsetTimeLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(5)
            make.top.equalTo(contentView).inset(167)
        }
        
        let tempStack = UIStackView(arrangedSubviews: [tempLabel, weatherConditionImage])
        tempStack.setCustomSpacing(5, after: tempLabel)
        addSubview(tempStack)
        tempStack.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX).offset(20)
            make.top.equalTo(contentView).inset(58)
        }
        
        weatherConditionImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        addSubview(weatherConditionLabel)
        weatherConditionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(tempStack.snp.centerX)
            make.top.equalTo(tempStack.snp.bottomMargin).inset(-5)
        }
        
        
        let stackWindSpeedAndHumidityStack = UIStackView(arrangedSubviews: [windSpeedImage, windSpeedILabel, humidityImage, humidityLabel])
        stackWindSpeedAndHumidityStack.setCustomSpacing(5, after: windSpeedImage)
        stackWindSpeedAndHumidityStack.setCustomSpacing(20, after: windSpeedILabel)
        stackWindSpeedAndHumidityStack.setCustomSpacing(5, after: humidityImage)
        addSubview(stackWindSpeedAndHumidityStack)

        windSpeedImage.snp.makeConstraints { make in
            make.width.equalTo(22)
            make.height.equalTo(16)
        }
        
        humidityImage.snp.makeConstraints { make in
            make.width.equalTo(13)
            make.height.equalTo(15)
        }

        stackWindSpeedAndHumidityStack.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottomMargin).inset(-30)
            make.centerX.equalTo(contentView.snp.centerX).offset(20)
        }
        
        addSubview(dateAndTimeLabel)
        dateAndTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX).offset(20)
            make.top.equalTo(stackWindSpeedAndHumidityStack.snp.bottom).offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by weatherViewModel: WeatherViewModel) {
        guard let currentWeather = weatherViewModel.weather else {return}
        
        let settings = weatherViewModel.getSettings()
        
        tempLabel.text = getTempAsString(temp: currentWeather.fact.temp, format: settings.tempDisplayMode)
        weatherConditionLabel.text = currentWeather.fact.conditionLocalized()
        weatherConditionImage.download(icon: currentWeather.fact.icon)
        windSpeedILabel.text = getWindSpeedAsString(windSpeed: currentWeather.fact.windSpeed, format: settings.windSpeedDisplayMode)
        humidityLabel.text = String(currentWeather.fact.humidity)+"%"
        
        dateAndTimeLabel.text = getCurrentDateAndTimeAsString(date: Date(), format: settings.timeFormat)
        
        if let todayForecast = currentWeather.forecasts.first {
            sunriseTimeLabel.text = todayForecast.sunrise
            sunsetTimeLabel.text = todayForecast.sunset
        }
        
    }
    
    private func getTempAsString(temp: Int, format: TempDisplayMode) -> String {
        if (format == .celsius) {
            return "\(temp)\u{00B0}"
        }
        
        return "\(temp.toFahrengeit())\u{00B0}"
    }
    
    private func getWindSpeedAsString(windSpeed: Double, format: WindSpeedDisplayMode) -> String {
        if (format == .kilometers) {
            return "\(String(format: "%.1f", windSpeed)) m\\s"
        }
        
        return "\(String(format: "%.1f", windSpeed.toMilesPerHour())) mi\\h"
    }
    
    private func getCurrentDateAndTimeAsString(date: Date, format: TimeFormat) -> String {
        let dateFormatter = DateFormatter()
        if (format == .hours12) {
            dateFormatter.dateFormat = "hh:mm, d MMMM"
        } else {
            dateFormatter.dateFormat = "HH:mm, d MMMM"
        }
        return dateFormatter.string(from: date)
    }
}
