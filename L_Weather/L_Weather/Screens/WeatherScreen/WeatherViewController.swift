
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
        tableView.register(TodayDetailsTableViewCell.self, forCellReuseIdentifier: TodayDetailsTableViewCell.identifier)
        tableView.register(ForecastHeaderTableViewCell.self, forCellReuseIdentifier: ForecastHeaderTableViewCell.identifier)
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        
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
        pageViewController?.title = weatherViewModel.getLocationTitle()
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            guard let pageViewController = self.parent as? WeatherPageViewController else {return}
            
            let weatherHourlyViewController = WeatherHourlyViewController(weatherViewModel: weatherViewModel)
               
            pageViewController.navigationController?.pushViewController(weatherHourlyViewController, animated: true)
        }
    }
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
            cell.selectionStyle = .none
            
            if weatherViewModel.isReady {
                cell.update(by: weatherViewModel)
            }
         
            return cell
        }
        
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayDetailsTableViewCell.identifier, for: indexPath) as! TodayDetailsTableViewCell
            cell.selectionStyle = .none
            
            if weatherViewModel.isReady {
                cell.update(weatherViewModel: weatherViewModel)
            }
            
            return cell
        }
        
        if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: ForecastHeaderTableViewCell.identifier, for: indexPath) as! ForecastHeaderTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
        if (indexPath.section == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
            
            if weatherViewModel.isReady {
                cell.update(by: weatherViewModel.forecasts[indexPath.row])
            }
            
            cell.selectionStyle = .none
            
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Краткая сводка
        if (indexPath.section == 0) {
            return 212
        }
        
        // Прогноз на 24 часа ))
        if (indexPath.section == 1) {
            return 180
        }
        
        // Заголовок Ежедневный прогноз
        if (indexPath.section == 2) {
            return 40
        }
        
        // Ячейка для выбора ежедневного прогноза
        if (indexPath.section == 3) {
            return 66
        }
        
        return 0
    }
}
