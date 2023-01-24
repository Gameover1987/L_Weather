
import UIKit
import SnapKit

final class HourTableViewCell : UITableViewCell {
    
    static let identifier = "HourTableViewCell"
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium18
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = Colors.Weather.Hourly.tableTextColor
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium18
        return label
    }()
    
    private lazy var feelsLikeIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "FeelsLike"))
        return imageView
    }()
    
    private lazy var feelsLikeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "По ощущениям"
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = Colors.Weather.Hourly.tableTextColor
        return label
    }()
    
    private lazy var windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Wind_Dark")
        return imageView
    }()
    
    private lazy var windTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "Ветер"
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = Colors.Weather.Hourly.tableTextColor
        return label
    }()
    
    private lazy var precipitationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Precipitation")
        return imageView
    }()
    
    private lazy var precipitationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "Атмосферные осадки"
        return label
    }()
    
    private lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = Colors.Weather.Hourly.tableTextColor
        return label
    }()
    
    private lazy var cloudnessIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloudness-2")
        return imageView
    }()
    
    private lazy var cloudnessTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "Облачность"
        return label
    }()
    
    private lazy var cloudnessLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.textColor = Colors.Weather.Hourly.tableTextColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.Weather.Hourly.tableBackground
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.top.equalTo(contentView).inset(16)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(dateLabel.snp.bottom).inset(-8)
        }
        
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(22)
            make.top.equalTo(timeLabel.snp.bottom).inset(-10)
        }
        
        contentView.addSubview(feelsLikeIcon)
        feelsLikeIcon.snp.makeConstraints({ make in
            make.left.equalTo(contentView).inset(74)
            make.top.equalTo(contentView).inset(45)
            make.width.equalTo(20)
            make.height.equalTo(18)
        })
        
        contentView.addSubview(feelsLikeTitleLabel)
        feelsLikeTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(feelsLikeIcon.snp.right).inset(-5)
            make.top.equalTo(contentView).inset(45)
        }
        
        contentView.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(45)
            make.right.equalTo(contentView).inset(16)
        }
        
        
        contentView.addSubview(windIcon)
        windIcon.snp.makeConstraints({ make in
            make.left.equalTo(contentView).inset(74)
            make.top.equalTo(contentView).inset(72)
            make.width.equalTo(20)
            make.height.equalTo(14)
        })
        
        contentView.addSubview(windTitleLabel)
        windTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(feelsLikeIcon.snp.right).inset(-5)
            make.top.equalTo(contentView).inset(72)
        }
        
        contentView.addSubview(windLabel)
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(72)
            make.right.equalTo(contentView).inset(16)
        }
        
        contentView.addSubview(precipitationIcon)
        precipitationIcon.snp.makeConstraints({ make in
            make.left.equalTo(contentView).inset(74)
            make.top.equalTo(contentView).inset(99)
            make.width.equalTo(20)
            make.height.equalTo(18)
        })
        
        contentView.addSubview(precipitationTitleLabel)
        precipitationTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(feelsLikeIcon.snp.right).inset(-5)
            make.top.equalTo(contentView).inset(99)
        }
        
        contentView.addSubview(precipitationLabel)
        precipitationLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(99)
            make.right.equalTo(contentView).inset(16)
        }
        
        contentView.addSubview(cloudnessIcon)
        cloudnessIcon.snp.makeConstraints({ make in
            make.left.equalTo(contentView).inset(74)
            make.top.equalTo(contentView).inset(126)
            make.width.equalTo(24)
            make.height.equalTo(17)
        })
        
        contentView.addSubview(cloudnessTitleLabel)
        cloudnessTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(feelsLikeIcon.snp.right).inset(-5)
            make.top.equalTo(contentView).inset(126)
        }
        
        contentView.addSubview(cloudnessLabel)
        cloudnessLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(126)
            make.right.equalTo(contentView).inset(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by hour: HourDetailsViewModel) {
        dateLabel.text = hour.dateAsString
        timeLabel.text = hour.timeAsString
        tempLabel.text = hour.temp
        feelsLikeLabel.text = hour.feelsLike
        windLabel.text = hour.wind
        precipitationLabel.text = hour.precipitation
        cloudnessLabel.text = hour.cloudness
    }
}
