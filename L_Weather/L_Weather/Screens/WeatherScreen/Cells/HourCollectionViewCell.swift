
import UIKit
import SnapKit

final class HourCollectionViewCell : UICollectionViewCell {
    static let identifier = "HourCollectionViewCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular16
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(15)
            make.centerX.equalTo(contentView)
        }

        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(10)
            make.centerX.equalTo(contentView)
        }
        
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = Colors.WeatherHourly.hourBorderColor.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by hour: HourViewModel) {
        timeLabel.text = hour.time
        icon.download(icon: hour.iconName)
        tempLabel.text = hour.temp
    }
    
    func select() {
        backgroundColor = Colors.WeatherHourly.hourSelectedBackground
        timeLabel.textColor = .white
        tempLabel.textColor = .white
    }
    
    func deselect() {
        backgroundColor = .white
        timeLabel.textColor = .black
        tempLabel.textColor = .black
    }
}
