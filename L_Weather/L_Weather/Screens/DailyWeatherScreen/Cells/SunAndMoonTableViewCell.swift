
import UIKit
import SnapKit

final class SunAndMoonTableViewCell : UITableViewCell {
    
    static let identifier = "SunAndMoonTableViewCell"
    
    private lazy var sunAndMoonTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        label.text = "Солнце и Луна"
        return label
    }()
    
    private lazy var smallEllipseIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse_Small")
        return imageView
    }()
    
    private lazy var moonPhazeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        return label
    }()
    
    private lazy var sunIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sun")
        return imageView
    }()
    
    private lazy var dayLengthLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        return label
    }()
    
    private lazy var sunriseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = Colors.Weather.Daily.sunAndMoonTextColor
        label.text = "Восход"
        return label
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        return label
    }()
    
    private lazy var sunsetTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = Colors.Weather.Daily.sunAndMoonTextColor
        label.text = "Заход"
        return label
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(sunAndMoonTitleLabel)
        sunAndMoonTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).inset(10)
        }
        
        let moonStack = UIStackView(arrangedSubviews: [smallEllipseIcon, moonPhazeLabel])
        moonStack.setCustomSpacing(5, after: smallEllipseIcon)
        
        smallEllipseIcon.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        contentView.addSubview(moonStack)
        moonStack.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).inset(13)
        }
        
        contentView.addSubview(sunIcon)
        sunIcon.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(37)
            make.top.equalTo(sunAndMoonTitleLabel.snp.bottom).inset(-20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        contentView.addSubview(dayLengthLabel)
        dayLengthLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(204)
            make.top.equalTo(moonPhazeLabel.snp.bottom).inset(-18)
        }
        
        let separator1 = createSeparator()
        contentView.addSubview(separator1)
        separator1.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(dayLengthLabel.snp.bottom).inset(-12)
            make.width.equalTo(160)
            make.height.equalTo(1)
        }
        
        contentView.addSubview(sunriseTitleLabel)
        sunriseTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(37)
            make.top.equalTo(separator1.snp.bottom).inset(-8)
        }
        
        contentView.addSubview(sunriseLabel)
        sunriseLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(204)
            make.top.equalTo(separator1.snp.bottom).inset(-8)
        }
        
        let separator2 = createSeparator()
        contentView.addSubview(separator2)
        separator2.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(sunriseTitleLabel.snp.bottom).inset(-12)
            make.width.equalTo(160)
            make.height.equalTo(1)
        }
        
        contentView.addSubview(sunsetTitleLabel)
        sunsetTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(37)
            make.top.equalTo(separator2.snp.bottom).inset(-8)
        }
        
        contentView.addSubview(sunsetLabel)
        sunsetLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(204)
            make.top.equalTo(separator2.snp.bottom).inset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSeparator() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DashedSeparator")
        return imageView
    }
    
    func update(by forecast: ForecastViewModel) {
        moonPhazeLabel.text = forecast.moonDescription
        dayLengthLabel.text = forecast.dayLength
        sunriseLabel.text = forecast.sunrise
        sunsetLabel.text = forecast.sunset
    }
}
