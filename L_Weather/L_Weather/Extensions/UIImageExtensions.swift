
import UIKit
import SVGKit

extension UIImageView {
    
    func download(icon: String) {
        guard let yandexImagePackUrl = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg") else {
            print("Не удалось загрузить иконку погодного условия")
            return
        }
        
        if let svgImage = SvgImageCache.shared.getImage(icon: icon) {
            self.image = svgImage.uiImage
        }
        else {
            DispatchQueue.global().async {
                guard let svgImage = SVGKImage(contentsOf: yandexImagePackUrl) else { return }
                
                DispatchQueue.main.async {
                    SvgImageCache.shared.addImage(key: icon, image: svgImage)
                    self.image = svgImage.uiImage
                }
            }
        }

    }
}


final class SvgImageCache {
    static let shared = SvgImageCache()
    
    private init() {
        
    }
    
    private var dictionary: [String:SVGKImage] = [:]
    
    func getImage(icon: String) -> SVGKImage? {
        return dictionary[icon]
    }
    
    func addImage(key: String, image: SVGKImage) {
        dictionary[key] = image
    }
}

