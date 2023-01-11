
import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        view.backgroundColor = Colors.settingsBackground
        
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var cloudImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloud-1")
        return imageView
    }()
    
    private lazy var cloudImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloud-2")
        return imageView
    }()
    
    private lazy var cloudImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloud-3")
        return imageView
    }()
    
    private lazy var settingsPanel: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.settingsPanelBackground
        view.layer.backgroundColor = Colors.settingsPanelBackground.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = Fonts.rubikMedium18
        return label
    }()
    
    private func setupLayout() {
        view.addSubview(cloudImage1)
        view.addSubview(cloudImage2)
        view.addSubview(settingsPanel)

        view.addSubview(cloudImage3)
        
        cloudImage1.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        
        cloudImage2.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.top.equalTo(cloudImage1.snp.bottom).offset(25)
        }
        
        settingsPanel.snp.makeConstraints { make in
            make.top.equalTo(cloudImage2.snp.bottom).offset(25)
            make.height.equalTo(330)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(27)
            
            settingsPanel.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(titleLabel.superview!).inset(20)
                make.top.equalTo(titleLabel.superview!).inset(27)
            }
        }
        
        cloudImage3.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(79)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-94)
        }
        
    }
}
