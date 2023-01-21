
import UIKit
import SnapKit

final class DailyWeatherViewController: UIViewController {
    
    private let weatherViewModel: WeatherViewModel
    private var numberOfDay: Int
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "Дневная погода"
        label.font = Fonts.rubikRegular16
        label.textColor = .gray
        return label
    }()
    
    private lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium18
        label.textColor = .black
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(DayOfWeekCollectionViewCell.self, forCellWithReuseIdentifier: DayOfWeekCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
      
        collectionView.allowsMultipleSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(PartOfDayTableViewCell.self, forCellReuseIdentifier: PartOfDayTableViewCell.identifier)
        tableView.register(SunAndMoonTableViewCell.self, forCellReuseIdentifier: SunAndMoonTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    init(numberOfDay: Int, weatherViewModel: WeatherViewModel) {
        self.numberOfDay = numberOfDay
        self.weatherViewModel = weatherViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.width.equalTo(15)
            make.height.equalTo(9)
        }

        view.addSubview(backLabel)
        backLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        view.addSubview(locationTitleLabel)
        locationTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.top.equalTo(backLabel.snp.bottom).offset(15)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(locationTitleLabel.snp.bottom).inset(-40)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(36)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(collectionView.snp.bottom).inset(-40)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        locationTitleLabel.text = weatherViewModel.getLocationTitle()
        
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DailyWeatherViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 36)
    }
}

extension DailyWeatherViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayOfWeekCollectionViewCell else {return}
        cell.select()
        if let oldCell = collectionView.cellForItem(at: IndexPath(item: numberOfDay, section: 0)) as? DayOfWeekCollectionViewCell {
            oldCell.deselect()
        }
      
        numberOfDay = indexPath.row
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayOfWeekCollectionViewCell else {return}
        cell.deselect()
        numberOfDay = -1
        tableView.reloadData()
    }
}

extension DailyWeatherViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = weatherViewModel.forecasts.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayOfWeekCollectionViewCell.identifier, for: indexPath) as! DayOfWeekCollectionViewCell
        if (indexPath.row == numberOfDay) {
            cell.select()
        } else {
            cell.deselect()
        }
        
        cell.update(by: weatherViewModel.forecasts[indexPath.row])
       
        return cell
    }
}

extension DailyWeatherViewController : UITableViewDelegate {
    
}

extension DailyWeatherViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        default:
            fatalError("Неизвестная секция")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (numberOfDay == -1) {
            return UITableViewCell()
        }
        
        let selectedForecast = weatherViewModel.forecasts[numberOfDay]
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: PartOfDayTableViewCell.identifier, for: indexPath) as! PartOfDayTableViewCell
            if (indexPath.row == 0) {
                cell.update(by: selectedForecast.morning)
            } else if (indexPath.row) == 1 {
                cell.update(by: selectedForecast.day)
            } else if (indexPath.row) == 2 {
                cell.update(by: selectedForecast.evening)
            } else if (indexPath.row) == 3 {
                cell.update(by: selectedForecast.night)
            }
            
            return cell
        }
        
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: SunAndMoonTableViewCell.identifier, for: indexPath) as! SunAndMoonTableViewCell
            cell.update(by: selectedForecast)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 353
        }
        
        if (indexPath.section == 1) {
            return 180
        }
        
        if (indexPath.section == 2) {
            return 170
        }
        
        return 0
    }
}
