
import Foundation
import CoreLocation



final class LocationManager {
    
    static let shared = LocationManager()
    
    private init() {
        
    }
    
    private let locationManagerCore = CLLocationManager()
    
    var isLocationAccessEnabled: Bool {
        let authorizationStatus = locationManagerCore.authorizationStatus
        
        return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
    }
    
    func requestLocationAccess() {
        locationManagerCore.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation(){
        locationManagerCore.startUpdatingLocation()
    }
    
    weak var delegate: CLLocationManagerDelegate? {
        get { return locationManagerCore.delegate }
        set { locationManagerCore.delegate = newValue}
    }
}
