
import Foundation
import CoreLocation

final class CoreLocationGeocoder : LocationGeocoderProtocol {
    
    static let shared = CoreLocationGeocoder()
    
    private init() {
        
    }
    
    func decodeLocation(by locationName: String, completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locationName) { placemarks, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let firstPlaceMark = placemarks?.first else {
                completion(nil)
                return
            }

            completion(firstPlaceMark)
        }
    }
}
