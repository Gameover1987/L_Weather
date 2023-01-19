
import UIKit
import SnapKit

final class DailyForecastTableViewCell : UITableViewCell {
    
    static let identifier = "DailyForecastTableViewCell"
    
    private lazy var panel: UIView = {
        let panel = UIView()
        panel.backgroundColor = Colors.Weather.Daily.backgroundColor
        
        panel.layer.cornerRadius = 5
        panel.layer.borderWidth = 1
        panel.layer.borderColor = Colors.Weather.Hourly.hourBorderColor.cgColor
        
        return panel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(panel)
        panel.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
