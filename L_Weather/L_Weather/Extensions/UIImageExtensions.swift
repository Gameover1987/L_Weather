
import UIKit
import SVGKit

extension UIImageView {
    func download(icon: String) {
        guard let yandexImagePackUrl = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg") else {
            print("Не удалось загрузить иконку погодного условия")
            return
        }
        
        DispatchQueue.global().async {
            let mySVGImage: SVGKImage = SVGKImage(contentsOf: yandexImagePackUrl)
            
            DispatchQueue.main.async {
                self.image = mySVGImage.uiImage
            }
        }
    }
}

