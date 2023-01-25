
import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
 
    private let onboardingViewModel: OnboardingViewModel
    
    private lazy var logo: UIImageView = {
        let image = UIImage(named: "logo")!
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }()
    
    private lazy var locationRequestLabel1: UILabel = {
        
        var label = UILabel()
        label.textColor = .white
        label.font = Fonts.rubikSemibold16
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.text = "Разрешить приложению \(Bundle.main.appName) использовать данные \nо местоположении вашего устройства"
        
        return label
    }()
    
    private lazy var locationRequestLabel2: UILabel = {
        
        var label = UILabel()
        label.textColor = .white
        label.font = Fonts.rubikRegular14
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        
        return label
    }()
    
    private lazy var locationRequestLabel3: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = Fonts.rubikRegular14
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.text = "Вы можете изменить свой выбор в любое время из меню приложения"
        
        return label
    }()
    
    private lazy var useDeviceLocationButton = CustomButton(action: useDeviceLocationAction,
                                                            color: Colors.Global.buttonColor,
                                                            title: "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА",
                                                            titleColor: .white,
                                                            font: Fonts.rubikMedium12)
    
    private lazy var withoutLocationButton = CustomButton(action: withoutDeviceLocationAction,
                                                          color: .clear, title: "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ",
                                                          titleColor: .white,
                                                          font: Fonts.rubikMedium16)
    
    
    init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = Colors.Onboarding.background
         
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func useDeviceLocationAction() {
        onboardingViewModel.locationsPolicy = .automatic
        
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.pushViewController(WeatherPageViewController(), animated: true)
    }
    
    private func withoutDeviceLocationAction() {
        onboardingViewModel.locationsPolicy = .manual
        
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.pushViewController(WeatherPageViewController(), animated: true)
    }
    
    private func setupLayout() {
        view.addSubview(logo)
        view.addSubview(locationRequestLabel1)
        view.addSubview(locationRequestLabel2)
        view.addSubview(locationRequestLabel3)
        view.addSubview(useDeviceLocationButton)
        view.addSubview(withoutLocationButton)
        
        logo.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).inset(110)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(147)
            make.width.equalTo(180)
            make.height.equalTo(196)
        }
        
        locationRequestLabel1.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottomMargin).offset(50)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        locationRequestLabel2.snp.makeConstraints { make in
            make.top.equalTo(locationRequestLabel1.snp.bottomMargin).offset(30)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        locationRequestLabel3.snp.makeConstraints { make in
            make.top.equalTo(locationRequestLabel2.snp.bottomMargin).offset(20)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        withoutLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(17)
        }
        
        useDeviceLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(withoutLocationButton.snp.top).inset(-10)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(17)
            make.height.equalTo(40)
        }
    }
}
