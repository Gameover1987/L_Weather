
import UIKit


extension UIImageView {
    func download(icon: String) {
        guard let yandexImagePackUrl = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg") else {
            print("Не удалось загрузить иконку погодного условия")
            return
        }
    
        let aaa = yandexImagePackUrl.absoluteString
        let image = UIImage(contentsOfFile: yandexImagePackUrl.absoluteString)
        
//        contentMode = .scaleAspectFit
//        URLSession.shared.dataTask(with: ynadexImagePackUrl) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//            else { return }
            
            
            
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
    }
}

