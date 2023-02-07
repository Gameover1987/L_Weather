
import UIKit
import SnapKit

final class DayOfWeekCollectionViewCell : UICollectionViewCell {
    static let identifier = "DayOfWeekCollectionViewCell"
    
    private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(dayOfWeekLabel)
        dayOfWeekLabel.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(contentView).inset(6)
        }
        
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by forecast: ForecastViewModelProtocol) {
        dayOfWeekLabel.text = forecast.dayOfWeek
    }
    
    func select() {
        backgroundColor = Colors.Weather.Daily.dayOfWeekSelectedBackground
        dayOfWeekLabel.textColor = .white
    }
    
    func deselect() {
        backgroundColor = .white
        dayOfWeekLabel.textColor = .black
    }
}
