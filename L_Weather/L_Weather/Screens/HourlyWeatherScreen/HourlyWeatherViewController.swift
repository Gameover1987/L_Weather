
import UIKit
import SnapKit

final class HourlyWeatherViewController: UIViewController {
    
    private let weatherViewModel: WeatherViewModel
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на 24 часа"
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
        collectionView.backgroundColor = Colors.Weather.Hourly.tableBackground
        
//        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
      
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(HourTableViewCell.self, forCellReuseIdentifier: HourTableViewCell.identifier)
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Colors.Weather.Hourly.tableSeparatorColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    init(weatherViewModel: WeatherViewModel) {
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
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(locationTitleLabel.snp.bottom).inset(-15)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(152)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(-20)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        locationTitleLabel.text = weatherViewModel.getLocationTitle()
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

extension HourlyWeatherViewController : UITableViewDelegate {
    
}

extension HourlyWeatherViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hourlyWeather = weatherViewModel.hourlyWeather else {
            return 0
        }
        
        return hourlyWeather.hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hourlyWeather = weatherViewModel.hourlyWeather else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HourTableViewCell.identifier, for: indexPath) as! HourTableViewCell
        cell.update(by: hourlyWeather.hours[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
