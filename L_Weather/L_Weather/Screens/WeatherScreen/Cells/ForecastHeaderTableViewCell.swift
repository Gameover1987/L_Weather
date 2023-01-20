
import UIKit
import SnapKit

final class ForecastHeaderTableViewCell : UITableViewCell {
    
    static let identifier = "DailyForecastHeaderTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium18
        label.text = "Ежедневный прогноз"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
