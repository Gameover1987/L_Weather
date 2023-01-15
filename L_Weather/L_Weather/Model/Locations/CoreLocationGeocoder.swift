
import Foundation
import CoreLocation

final class CoreLocationGeocoder : LocationGeocoderProtocol {
    
    static let shared = CoreLocationGeocoder()
    
    private init() {
        
    }
    
    func decodeLocation(by locationName: String, completion: @escaping (CLLocation?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locationName) { placemarks, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location else {
                completion(nil)
                return
            }
            
            completion(location)
        }
    }
}
