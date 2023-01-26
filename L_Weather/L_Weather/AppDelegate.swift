
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window
        
        let settingsProvider = UserDefaultsSettingsProvider.shared
        
        let onboardingViewModel = OnboardingViewModel(settingsProvider: settingsProvider)
      
        let navigationController = UINavigationController()
        
        let locationsPolicy = settingsProvider.getLocationsPolicy()
        if locationsPolicy == nil {
            let onboardingController = OnboardingViewController(onboardingViewModel: onboardingViewModel)
            navigationController.setViewControllers([onboardingController], animated: true)
        }
        else {
            let weatherPageViewController = WeatherPageViewController()
            navigationController.setViewControllers([weatherPageViewController], animated: true)
        }
        
        window.rootViewController = navigationController
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
        
        return true
    }
}
