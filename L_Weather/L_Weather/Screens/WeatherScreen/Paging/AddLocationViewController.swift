
import UIKit
import SnapKit

final class AddLocationViewController : UIViewController {
    
    private lazy var addLocationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addLocationAction), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = Colors.Weather.background
        
        view.addSubview(addLocationButton)
        
        addLocationButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pageViewController  = self.parent as? WeatherPageViewController
        pageViewController?.title = ""
    }
    
    @objc
    private func addLocationAction() {
        guard let pageViewController = self.parent as? WeatherPageViewController else {return}
        pageViewController.addLocationAction()
    }
}
