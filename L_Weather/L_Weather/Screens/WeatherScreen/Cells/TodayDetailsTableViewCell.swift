
import UIKit
import SnapKit

final class TodayDetailsTableViewCell : UITableViewCell {
    static let identifier = "TodayDetails24Hours"
    
    private var weatherViewModel: WeatherViewModel? = nil
    
    private lazy var details24HoursLabel: UILabel = {
        let label = UILabel()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Подробнее на 24 часа", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        
        label.backgroundColor = .white
        label.font = Fonts.rubikRegular16
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
      
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(details24HoursLabel)
        details24HoursLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(30)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(details24HoursLabel.snp.bottom).offset(24)
            make.left.equalTo(contentView).inset(16)
            make.right.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(weatherViewModel: WeatherViewModel) {
        self.weatherViewModel = weatherViewModel
        
        collectionView.reloadData()
    }
}

extension TodayDetailsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let settings = UserDefaultsSettingsProvider.shared.get()
        if (settings.timeFormat == .hours12) {
            return CGSize(width: 65, height: 100)
        }
        
        return CGSize(width: 50, height: 100)
    }
}

extension TodayDetailsTableViewCell: UICollectionViewDelegate {
    
}

extension TodayDetailsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let weatherViewModel = weatherViewModel else { return 0 }
        
        return weatherViewModel.hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let weatherViewModel = weatherViewModel else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath) as! HourCollectionViewCell
        cell.update(by: weatherViewModel.hours[indexPath.row])
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HourCollectionViewCell else {return}
        cell.select()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HourCollectionViewCell else {return}
        cell.deselect()
    }
}
