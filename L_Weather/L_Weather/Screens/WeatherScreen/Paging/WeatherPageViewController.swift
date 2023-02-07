
import UIKit
import SnapKit
import CoreLocation

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
        self.weatherPageViewModel = WeatherPageViewModel (
            locationsProvider: LocationsCoreDataProvider.shared,
            weatherViewModelFactory: WeatherViewModelFactory.shared,
            locationGeocoder: CoreLocationGeocoder.shared
        )
        
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        
        self.weatherPageViewModel.locationAddedHandler = self.locationAddedHandler(weatherViewModel:)
        self.weatherPageViewModel.locationRemovedHandler = self.locationRemovedHandler(weatherViewModel:)
        self.weatherPageViewModel.currentLocationUpdatedHandler = self.currentLocationUpdatedHandler(weatherViewModel:)
        
        self.delegate = self
        self.dataSource = self
        
        LocationManager.shared.delegate = self
        if (UserDefaultsSettingsProvider.shared.getLocationsPolicy() == .automatic ) {
            LocationManager.shared.requestLocationAccess()
        }
        
        weatherViewControllers = weatherPageViewModel.weatherByLocations.map({ weatherViewModel in
            return WeatherViewController(weatherViewModel: weatherViewModel)
        })
        
        if weatherViewControllers.count == 0 {
            weatherViewControllers.append(addLocationViewController)
        }
        
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
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.addTarget(self, action: #selector(longPressNavigationBarAction))
        
        self.navigationItem.rightBarButtonItem = locationItem
        self.navigationItem.leftBarButtonItem = settingsItem
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.addGestureRecognizer(longPressGestureRecognizer)
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageControl.numberOfPages = weatherViewControllers.count
        pageControl.currentPage = 0
    }
    
    @objc
    private func longPressNavigationBarAction() {
        guard let currentController = self.viewControllers?.first as? WeatherViewController else { return }
        if currentController.showCurrentLocation {
            return
        }
        
        showQuestionDialog(title: "Удаление", message: "Больше не показывать погоду по \(title!)?") { [weak self] isOk in
            if !isOk {
                return
            }
            guard let self = self else { return }
            guard let currentController = self.viewControllers?.first as? WeatherViewController else { return }
            
            self.weatherPageViewModel.removeLocation(weatherViewModel: currentController.weatherViewModel)

        }
    }

    @objc
    private func showSettingsAction() {
        let settingsViewModel = SettingsViewModel(settingsProvider: UserDefaultsSettingsProvider.shared)
        let settingsController = SettingsViewController(settingsViewModel: settingsViewModel)
        settingsViewModel.settingsSavedAction = { [weak self] in
            settingsController.dismiss(animated: true)
           
            self?.weatherViewControllers.forEach { viewController in
                guard let weatherViewController = viewController as? WeatherViewController else {return}
                
                weatherViewController.reload()
            }
        }
        
        self.present(settingsController, animated: true)
    }
    
    @objc
    func addLocationAction() {
        self.showInputDialog(title: "Добаление меcтоположения", message: "") { [weak self] text in
            guard let text = text else { return }
            
            self?.weatherPageViewModel.addLocation(locationName: text)
        }
    }
    
    private func locationAddedHandler(weatherViewModel: WeatherViewModelProtocol) {
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
    
    private func locationRemovedHandler(weatherViewModel: WeatherViewModelProtocol) {
        let currentController = self.weatherViewControllers.first { viewController in
            guard let weatherViewController = viewController as? WeatherViewController else {return false}
            
            return weatherViewController.weatherViewModel === weatherViewModel
        }
        guard let currentController = currentController else {return}
        
        let currentIndex = self.weatherViewControllers.firstIndex(of: currentController)!
        var nextController: WeatherViewController?
        var priorController: WeatherViewController?
        if currentIndex < self.weatherViewControllers.count - 1 {
            nextController = self.weatherViewControllers[currentIndex + 1] as? WeatherViewController
        }
        if currentIndex > 0 {
            priorController = self.weatherViewControllers[currentIndex - 1] as? WeatherViewController
        }
        
        self.weatherViewControllers.removeAll { viewController in
            viewController == currentController
        }
        
        if nextController != nil {
            self.setViewControllers([nextController!], direction: .forward, animated: true)
        } else if priorController != nil {
            self.setViewControllers([priorController!], direction: .forward, animated: true)
            self.pageControl.currentPage -= 1
        } else if weatherViewControllers.count == 0 {
            weatherViewControllers.append(addLocationViewController)
            self.setViewControllers([addLocationViewController], direction: .forward, animated: true)
        }
        
        let pagesCount = self.weatherViewControllers.count
        self.pageControl.numberOfPages = pagesCount
    }
    
    private func currentLocationUpdatedHandler(weatherViewModel: WeatherViewModelProtocol) {
        var currentLocationController = self.weatherViewControllers.first { controller in
            guard let weatherController = controller as? WeatherViewController else {return false}
            
            return weatherController.showCurrentLocation
        } as? WeatherViewController
        
        if (currentLocationController == nil) {
            currentLocationController = WeatherViewController(weatherViewModel: weatherViewModel)
            currentLocationController?.showCurrentLocation = true
            
            weatherViewControllers.insert(currentLocationController!, at: 0)
        } else {
            currentLocationController!.reload(by: weatherViewModel)
        }
        
        self.setViewControllers([currentLocationController!], direction: .forward, animated: true)
        let pagesCount = self.weatherViewControllers.count
        self.pageControl.numberOfPages = pagesCount
    }
}

extension WeatherPageViewController : CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            
            LocationManager.shared.startUpdatingLocation()
            
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        weatherPageViewModel.loadLocation(by: locations.first!)
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
