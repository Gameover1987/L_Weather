
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
    
    private lazy var weatherConditionIcon: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "Humidity")
        return imageView
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
        
        addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX).offset(20)
            make.top.equalTo(contentView).inset(58)
        }
        
        addSubview(weatherConditionLabel)
        weatherConditionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(tempLabel.snp.centerX)
            make.top.equalTo(tempLabel.snp.bottomMargin).inset(-5)
        }
        
        let windSpeedStackView = UIStackView(arrangedSubviews: [windSpeedImage, windSpeedILabel])
        windSpeedStackView.spacing = 9
        addSubview(windSpeedStackView)
        
        windSpeedImage.snp.makeConstraints { make in
            make.width.equalTo(22)
            make.height.equalTo(16)
        }
        
        windSpeedStackView.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottomMargin).inset(-30)
            make.centerX.equalTo(contentView.snp.centerX).offset(20)
        }
        
        let humidityStackView = UIStackView(arrangedSubviews: [humidityImage, humidityLabel])
        humidityStackView.spacing = 9
        
        addSubview(humidityStackView)
        
        humidityImage.snp.makeConstraints { make in
            make.width.equalTo(22)
            make.height.equalTo(16)
        }
        
        humidityStackView.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottomMargin).inset(-30)
            make.left.equalTo(windSpeedStackView.snp.right).inset(-20)
        }
        
        addSubview(weatherConditionIcon)
        weatherConditionIcon.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottomMargin).inset(-30)
            make.right.equalTo(windSpeedStackView.snp.left).inset(-20)
            make.width.equalTo(20)
            make.height.equalTo(20)
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
        weatherConditionIcon.download(icon: currentWeather.fact.icon)
        windSpeedILabel.text = getWindSpeedAsString(windSpeed: currentWeather.fact.windSpeed, format: settings.windSpeedDisplayMode)
        humidityLabel.text = String(currentWeather.fact.humidity)
        
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
}
