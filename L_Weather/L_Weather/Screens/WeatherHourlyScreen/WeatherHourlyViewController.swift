
import UIKit
import SnapKit

final class WeatherHourlyViewController: UIViewController {
    
    private let weatherViewModel: WeatherViewModel
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на 24 часа"
        label.font = Fonts.rubikRegular16
        label.textColor = .gray
        return label
    }()
    
    private lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium18
        label.textColor = .black
        return label
    }()
    
    init(weatherViewModel: WeatherViewModel) {
        self.weatherViewModel = weatherViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.width.equalTo(15)
            make.height.equalTo(9)
        }

        view.addSubview(backLabel)
        backLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        view.addSubview(locationTitleLabel)
        locationTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(backLabel.snp.bottom).offset(15)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        locationTitleLabel.text = weatherViewModel.getLocationTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
