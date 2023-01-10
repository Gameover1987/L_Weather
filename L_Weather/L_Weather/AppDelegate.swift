//
//  AppDelegate.swift
//  L_Weather
//
//  Created by Вячеслав on 10.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let lattitude = 55.01
        let longtitude = 82.55
        
        YandexWeatherApi.shared.performWeatherRequest(lattitude: lattitude, longtitude: longtitude) { result in
            
        }
        
        let window = UIWindow()
        self.window = window
        window.rootViewController = UIViewController()
        window.rootViewController?.view.backgroundColor = .yellow
        window.makeKeyAndVisible()
        
        return true
    }
}
