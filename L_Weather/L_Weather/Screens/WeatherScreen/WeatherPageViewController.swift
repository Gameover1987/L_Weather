
import UIKit
import SnapKit

final class WeatherPageViewController : UIPageViewController {
    
    private let weatherPageViewModel: WeatherPageViewModel
    private var weatherViewControllers: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        self.weatherPageViewModel = WeatherPageViewModel(
            locationsProvider: LocationsCoreDataProvider.shared,
            weatherViewModelFactory: WeatherViewModelFactory.shared,
            locationGeocoder: CoreLocationGeocoder.shared
        )
        
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        
        self.weatherPageViewModel.locationAddedHandler = self.locationAddedHandler(weatherViewModel:)
        
        weatherViewControllers = weatherPageViewModel.weatherByLocations.map({ weatherViewModel in
            return WeatherViewController(weatherViewModel: weatherViewModel)
        })
        
        if weatherViewControllers.count == 0 {
            weatherViewControllers.append(AddLocationViewController())
        }
        
        self.delegate = self
        self.dataSource = self
        
        setViewControllers([weatherViewControllers.first!], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Colors.Weather.panelBackground
        
        let settingsItem = UIBarButtonItem(image: UIImage(named: "menuIcon"), style: .plain, target: self, action: nil)
        settingsItem.tintColor = .black
        
        let locationItem = UIBarButtonItem(image: UIImage(named: "locationIcon"), style: .plain, target: self, action: #selector(addLocationAction))
        locationItem.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = locationItem
        self.navigationItem.leftBarButtonItem = settingsItem
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        
    }

    @objc
    func addLocationAction() {
        self.showInputDialog(title: "Добаление меcтоположения", message: "") { [weak self] text in
            guard let text = text else { return }
            
            self?.weatherPageViewModel.addLocation(locationName: text)
        }
    }
    
    private func locationAddedHandler(weatherViewModel: WeatherViewModel) {
        let weatherViewController = WeatherViewController(weatherViewModel: weatherViewModel)
        
        if weatherViewControllers.count == 1 {
            weatherViewControllers.removeAll()
        }
        
        weatherViewControllers.insert(weatherViewController, at: 0)
        
        setViewControllers([weatherViewController], direction: .forward, animated: true)
    }
}

extension WeatherPageViewController : UIPageViewControllerDelegate {
    
}

extension WeatherPageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = weatherViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return weatherViewControllers[index - 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = weatherViewControllers.firstIndex(of: viewController) {
            if index < weatherViewControllers.count - 1 {
                return weatherViewControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return weatherViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
