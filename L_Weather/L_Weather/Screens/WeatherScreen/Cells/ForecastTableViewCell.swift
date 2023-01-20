
import UIKit
import SnapKit

final class ForecastTableViewCell : UITableViewCell {
    
    static let identifier = "DailyForecastTableViewCell"
    
    private lazy var panel: UIView = {
        let panel = UIView()
        panel.backgroundColor = Colors.Weather.Daily.backgroundColor
        
        panel.layer.cornerRadius = 5
        panel.layer.borderWidth = 1
        panel.layer.borderColor = Colors.Weather.Hourly.hourBorderColor.cgColor
        
        return panel
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        label.textColor = Colors.Weather.Daily.dateColor
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var cloudnessLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular12
        label.textColor = Colors.Weather.Daily.cloudnessColor
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        label.textColor = .black
        return label
    }()
    
    private lazy var tempRangeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    private lazy var disclosureImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DisclosureRight")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(panel)
        panel.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(5)
            
            contentView.addSubview(dateLabel)
            dateLabel.snp.makeConstraints { make in
                make.left.equalTo(panel).inset(10)
                make.top.equalTo(panel).inset(6)
            }
            
            contentView.addSubview(icon)
            icon.snp.makeConstraints { make in
                make.left.equalTo(panel).inset(10)
                make.top.equalTo(dateLabel.snp.bottom).inset(-2)
                make.width.equalTo(20)
                make.height.equalTo(20)
            }
            
            contentView.addSubview(cloudnessLabel)
            cloudnessLabel.snp.makeConstraints { make in
                make.left.equalTo(icon.snp.right).inset(-5)
                make.top.equalTo(dateLabel.snp.bottom).inset(-6)
            }
            
            contentView.addSubview(disclosureImage)
            disclosureImage.snp.makeConstraints { make in
                make.centerY.equalTo(contentView)
                make.right.equalTo(contentView).inset(25)
                make.width.equalTo(6)
                make.height.equalTo(10)
            }
            
            contentView.addSubview(tempRangeLabel)
            tempRangeLabel.snp.makeConstraints { make in
                make.centerY.equalTo(contentView)
                make.right.equalTo(disclosureImage.snp.left).inset(-10)
            }
            
            contentView.addSubview(conditionLabel)
            conditionLabel.snp.makeConstraints { make in
                make.left.equalTo(panel).inset(73)
                make.centerY.equalTo(panel)
                make.right.equalTo(tempRangeLabel.snp.left).inset(-5)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by forecast: ForecastViewModel) {
        
        dateLabel.text = forecast.dateAsString
        
        icon.download(icon: forecast.icon)
        
        cloudnessLabel.text = forecast.cloudness
        
        conditionLabel.text = forecast.condtion
        
        tempRangeLabel.text = forecast.tempRange
    }
}
