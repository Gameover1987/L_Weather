
import Foundation
import CoreLocation

protocol LocationGeocoderProtocol {
    func decodeLocation(by locationName: String, completion: @escaping (_ location: CLLocation?) -> Void)
}


