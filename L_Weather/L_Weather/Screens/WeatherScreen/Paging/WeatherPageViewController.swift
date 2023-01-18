
import UIKit
import SnapKit

final class WeatherPageViewController : UIPageViewController {
    
    private let weatherPageViewModel: WeatherPageViewModel
    private var weatherViewControllers: [UIViewController] = []
    
    private lazy var addLocationViewController: AddLocationViewController = AddLocationViewController()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.clear
        return pageControl
    }()
    
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
            weatherViewControllers.append(addLocationViewController)
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
        
        let settingsItem = UIBarButtonItem(image: UIImage(named: "menuIcon"), style: .plain, target: self, action: #selector(showSettingsAction))
        settingsItem.tintColor = .black
        
        let locationItem = UIBarButtonItem(image: UIImage(named: "locationIcon"), style: .plain, target: self, action: #selector(addLocationAction))
        locationItem.tintColor = .black
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Fonts.rubikMedium18]
        
        self.navigationItem.rightBarButtonItem = locationItem
        self.navigationItem.leftBarButtonItem = settingsItem
        self.navigationController?.navigationBar.backgroundColor = .white
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageControl.numberOfPages = weatherViewControllers.count
        pageControl.currentPage = 0
    }

    @objc
    private func showSettingsAction() {
        let settingsViewModel = SettingsViewModel(settingsProvider: UserDefaultsSettingsProvider.shared)
        let settingsController = SettingsViewController(settingsViewModel: settingsViewModel)
        settingsViewModel.settingsSavedAction = { [weak self] in
            settingsController.dismiss(animated: true)
            //self?.navigationController?.popViewController(animated: true)
            self?.weatherViewControllers.forEach { viewController in
                guard let weatherViewController = viewController as? WeatherViewController else {return}
                
                weatherViewController.reload()
            }
        }
        
        self.present(settingsController, animated: true)
       
        //navigationController?.pushViewController(settingsController, animated: true)
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
        
        weatherViewControllers.removeAll { viewController in
            return viewController == addLocationViewController
        }
        
        let insertPosition = 0
        weatherViewControllers.insert(weatherViewController, at: insertPosition)
        
        setViewControllers([weatherViewController], direction: .forward, animated: true)
        
        let pages = weatherViewControllers.count
        pageControl.numberOfPages = pages
        pageControl.currentPage = insertPosition
    }
}

extension WeatherPageViewController : UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
          
        guard let firstViewController = viewControllers?.first else { return }
           
        guard let index = weatherViewControllers.firstIndex(of: firstViewController) else { return }
       
        pageControl.currentPage = index
    }
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
}
