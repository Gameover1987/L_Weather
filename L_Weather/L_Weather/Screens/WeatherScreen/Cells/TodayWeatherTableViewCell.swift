
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
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium36
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //backgroundColor = .red
        
        addSubview(panel)
        panel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.top.equalTo(contentView)
            make.right.equalTo(contentView).inset(0)
            make.height.equalTo(212)
        }
        
        addSubview(ellipseImage)
        ellipseImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(17)
            make.left.equalTo(contentView).inset(49)
            make.right.equalTo(contentView).inset(31)
        }
        
        addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.top.equalTo(contentView).inset(58)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by weatherViewModel: WeatherViewModel) {
        guard let currentWeather = weatherViewModel.weather else {return}
        
        tempLabel.text = "\(currentWeather.fact.temp)\u{00B0}"
    }
}
