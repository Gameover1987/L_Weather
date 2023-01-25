
import Foundation

extension LocationEntity {
    var locationDescription: String {
        guard let name = name, let country = country else {return ""}
        
        let title = "\(name), \(country)"
        return title
    }
}
