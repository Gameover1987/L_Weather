
import Foundation

protocol LocationsProviderProtocol {

    var locations: [LocationEntity] {get}
    
    func addLocation(name: String, latitude: Double, longtitude: Double) -> LocationEntity
}
