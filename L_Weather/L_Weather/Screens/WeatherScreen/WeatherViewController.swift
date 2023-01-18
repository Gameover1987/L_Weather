
import UIKit
import SnapKit

final class WeatherViewController : UIViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(TodayWeatherTableViewCell.self, forCellReuseIdentifier: TodayWeatherTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(weatherViewModel: WeatherViewModel) {
        self.weatherViewModel = weatherViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public let weatherViewModel: WeatherViewModel
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = Colors.Weather.background
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pageViewController  = self.parent as? WeatherPageViewController
        pageViewController?.title = "\(weatherViewModel.location.name!), \(weatherViewModel.location.country!)"
        
        activityIndicator.startAnimating()
        tableView.isHidden = true
        
        weatherViewModel.load { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error)
            
            case .success(_):
                print("Погода по '\(String(describing: self.weatherViewModel.location.name))' загружена!")
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    func reload() {
        tableView.reloadData()
    }
}

extension WeatherViewController : UITableViewDelegate {
    
}

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 7
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayWeatherTableViewCell.identifier, for: indexPath) as! TodayWeatherTableViewCell
            
            if weatherViewModel.weather != nil {
                cell.update(by: weatherViewModel)
            }
         
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 212
        }
        
        return 0
    }
}
