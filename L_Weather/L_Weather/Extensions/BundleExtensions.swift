
import Foundation

extension Bundle {
    var appName: String {
        let bundleInfoDict: NSDictionary = Bundle.main.infoDictionary! as NSDictionary
        let appName = bundleInfoDict["CFBundleName"] as! String
        return appName
    }
}
