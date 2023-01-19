
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
    
    private lazy var cloudnessImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloudness")
        return imageView
    }()
    
    private lazy var cloudnessLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
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
    
    private lazy var details24HoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Подробнее на 24 часа"
        label.textAlignment = .right
        label.backgroundColor = .white
        label.font = Fonts.rubikRegular16
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(panel)
        panel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.right.equalTo(contentView).inset(16)
            make.height.equalTo(212)
        }
        
        contentView.addSubview(ellipseImage)
        ellipseImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(17)
            make.left.equalTo(contentView).inset(49)
            make.right.equalTo(contentView).inset(49)
        }
        
        contentView.addSubview(sunriseImage)
        sunriseImage.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(42)
            make.top.equalTo(contentView).inset(145)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        contentView.addSubview(sunriseTimeLabel)
        sunriseTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(33)
            make.top.equalTo(contentView).inset(167)
        }
        
        contentView.addSubview(sunsetImage)
        sunsetImage.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(42)
            make.top.equalTo(contentView).inset(145)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        contentView.addSubview(sunsetTimeLabel)
        sunsetTimeLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(37)
            make.top.equalTo(contentView).inset(167)
        }
        
        let tempStack = UIStackView(arrangedSubviews: [tempLabel, weatherConditionImage])
        tempStack.setCustomSpacing(5, after: tempLabel)
        contentView.addSubview(tempStack)
        tempStack.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView).inset(58)
        }
        
        weatherConditionImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(weatherConditionLabel)
        weatherConditionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(tempStack.snp.centerX)
            make.top.equalTo(tempStack.snp.bottomMargin)
        }
        
        let addItionalInfoStack = UIStackView(arrangedSubviews: [cloudnessImage, cloudnessLabel, windSpeedImage, windSpeedILabel, humidityImage, humidityLabel])
        addItionalInfoStack.setCustomSpacing(5, after: cloudnessImage)
        addItionalInfoStack.setCustomSpacing(20, after: cloudnessLabel)
        addItionalInfoStack.setCustomSpacing(5, after: windSpeedImage)
        addItionalInfoStack.setCustomSpacing(20, after: windSpeedILabel)
        addItionalInfoStack.setCustomSpacing(5, after: humidityImage)
        contentView.addSubview(addItionalInfoStack)

        cloudnessImage.snp.makeConstraints { make in
            make.width.equalTo(21)
            make.height.equalTo(18)
        }
        
        windSpeedImage.snp.makeConstraints { make in
            make.width.equalTo(22)
            make.height.equalTo(16)
        }
        
        humidityImage.snp.makeConstraints { make in
            make.width.equalTo(13)
            make.height.equalTo(15)
        }

        addItionalInfoStack.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottomMargin).inset(-30)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        contentView.addSubview(dateAndTimeLabel)
        dateAndTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(addItionalInfoStack.snp.bottom).offset(15)
        }  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by weatherViewModel: WeatherViewModel) {
        tempLabel.text = weatherViewModel.getTemp()
        weatherConditionLabel.text = weatherViewModel.getWeatherConditionLocalized()
        weatherConditionImage.download(icon: weatherViewModel.getWeatherConditionIcon())
        cloudnessLabel.text = weatherViewModel.getCloudness()
        windSpeedILabel.text = weatherViewModel.getWindSpeed()
        humidityLabel.text = weatherViewModel.getHumidity()
        dateAndTimeLabel.text = weatherViewModel.getCurrentDateAndTime()
        sunriseTimeLabel.text = weatherViewModel.getSunrise()
        sunsetTimeLabel.text = weatherViewModel.getSunset()
    }
}
