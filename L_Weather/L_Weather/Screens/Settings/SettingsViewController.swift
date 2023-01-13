
import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private let settingsViewModel: SettingsViewModel
    
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
        view.backgroundColor = Colors.Settings.panelBackground
        view.layer.backgroundColor = Colors.Settings.panelBackground.cgColor
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
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.font = Fonts.rubikMedium18
        label.textColor = Colors.Settings.panelTextColor
        return label
    }()
    
    private lazy var tempSwitch: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["C", "F"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectedSegmentTintColor = Colors.Settings.switchIsOnBackground
        
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: Fonts.rubikRegular16]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.backgroundColor = .white
        
        segmentedControl.addTarget(self, action: #selector(tempSwitched), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "Скорость ветра"
        label.font = Fonts.rubikMedium18
        label.textColor = Colors.Settings.panelTextColor
        return label
    }()
    
    private lazy var windSpeedSwitch: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Mi", "Km"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectedSegmentTintColor = Colors.Settings.switchIsOnBackground
        
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: Fonts.rubikRegular16]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.backgroundColor = .white
        
        segmentedControl.addTarget(self, action: #selector(windSpeedSwitched), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var timeFormatLabel: UILabel = {
        let label = UILabel()
        label.text = "Формат времени"
        label.font = Fonts.rubikMedium18
        label.textColor = Colors.Settings.panelTextColor
        return label
    }()
    
    private lazy var timeFormatSwitch: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["12", "24"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectedSegmentTintColor = Colors.Settings.switchIsOnBackground
        
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: Fonts.rubikRegular16]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.backgroundColor = .white
        
        segmentedControl.addTarget(self, action: #selector(timeFormatSwitched), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var notificationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомления"
        label.font = Fonts.rubikMedium18
        label.textColor = Colors.Settings.panelTextColor
        return label
    }()
    
    private lazy var notificationsSwitch: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["On", "Off"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectedSegmentTintColor = Colors.Settings.switchIsOnBackground
        
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: Fonts.rubikRegular16]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.backgroundColor = .white
        
        segmentedControl.addTarget(self, action: #selector(notificationsEnabledSwitched), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var setSettingsButton: CustomButton = {
        let button = CustomButton(action: setSettingsButtonAction,
                                  color: Colors.orangeButtonColor,
                                  title: "Установить",
                                  titleColor: .white,
                                  font: Fonts.rubikMedium16)
        return button
    }()
    

    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
        super.init(nibName: nil, bundle: nil)
        
        tempSwitch.selectedSegmentIndex = settingsViewModel.tempDisplayMode.index()
        windSpeedSwitch.selectedSegmentIndex = settingsViewModel.windSpeedDisplayMode.index()
        timeFormatSwitch.selectedSegmentIndex = settingsViewModel.timeFormat.index()
        notificationsSwitch.selectedSegmentIndex = settingsViewModel.isNotificationsEnabled ? 0 : 1
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = Colors.Settings.background
        
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    private func tempSwitched(sender: UISegmentedControl) {
        settingsViewModel.tempDisplayMode = TempDisplayMode.from(index: sender.selectedSegmentIndex)
    }
    
    @objc
    private func windSpeedSwitched(sender: UISegmentedControl) {
        settingsViewModel.windSpeedDisplayMode = WindSpeedDisplayMode.from(index: sender.selectedSegmentIndex)
    }
    
    @objc
    private func timeFormatSwitched(sender: UISegmentedControl) {
        settingsViewModel.timeFormat = TimeFormat.from(index: sender.selectedSegmentIndex)
    }
    
    @objc
    private func notificationsEnabledSwitched(sender: UISegmentedControl) {
        settingsViewModel.isNotificationsEnabled = sender.selectedSegmentIndex == 0
    }
    
    private func setSettingsButtonAction() {
        self.settingsViewModel.save()
    }
    
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
            
            settingsPanel.addSubview(tempLabel)
            tempLabel.snp.makeConstraints { make in
                make.left.equalTo(titleLabel.superview!).inset(20)
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
            }
            
            settingsPanel.addSubview(tempSwitch)
            tempSwitch.snp.makeConstraints { make in
                make.right.equalTo(tempSwitch.superview!).inset(30)
                make.top.equalTo(titleLabel.snp.bottom).offset(15)
                make.width.equalTo(80)
                make.height.equalTo(30)
            }
            
            settingsPanel.addSubview(windSpeedLabel)
            windSpeedLabel.snp.makeConstraints { make in
                make.left.equalTo(windSpeedLabel.superview!).inset(20)
                make.top.equalTo(tempLabel.snp.bottom).offset(30)
            }
            
            settingsPanel.addSubview(windSpeedSwitch)
            windSpeedSwitch.snp.makeConstraints { make in
                make.right.equalTo(windSpeedSwitch.superview!).inset(30)
                make.top.equalTo(tempSwitch.snp.bottom).offset(20)
                make.width.equalTo(80)
                make.height.equalTo(30)
            }
            
            settingsPanel.addSubview(timeFormatLabel)
            timeFormatLabel.snp.makeConstraints { make in
                make.left.equalTo(timeFormatLabel.superview!).inset(20)
                make.top.equalTo(windSpeedLabel.snp.bottom).offset(30)
            }
            
            settingsPanel.addSubview(timeFormatSwitch)
            timeFormatSwitch.snp.makeConstraints { make in
                make.right.equalTo(timeFormatSwitch.superview!).inset(30)
                make.top.equalTo(windSpeedSwitch.snp.bottom).offset(20)
                make.width.equalTo(80)
                make.height.equalTo(30)
            }
            
            settingsPanel.addSubview(notificationsLabel)
            notificationsLabel.snp.makeConstraints { make in
                make.left.equalTo(notificationsLabel.superview!).inset(20)
                make.top.equalTo(timeFormatLabel.snp.bottom).offset(30)
            }
            
            settingsPanel.addSubview(notificationsSwitch)
            notificationsSwitch.snp.makeConstraints { make in
                make.right.equalTo(notificationsSwitch.superview!).inset(30)
                make.top.equalTo(timeFormatSwitch.snp.bottom).offset(20)
                make.width.equalTo(80)
                make.height.equalTo(30)
            }
            
            settingsPanel.addSubview(setSettingsButton)
            setSettingsButton.snp.makeConstraints { make in
                make.centerX.equalTo(setSettingsButton.superview!)
                make.bottom.equalTo(setSettingsButton.superview!).offset(-16)
                make.height.equalTo(40)
                make.width.equalTo(250)
            }
        }
        
        cloudImage3.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(79)
            make.top.equalTo(settingsPanel.snp_bottomMargin).offset(81)
        }
        
    }
}
