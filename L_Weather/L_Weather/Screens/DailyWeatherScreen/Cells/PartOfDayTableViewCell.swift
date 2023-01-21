
import UIKit
import SnapKit

final class PartOfDayTableViewCell : UITableViewCell {
    
    static let identifier = "PartOfDayTableViewCell"
    
    private lazy var panel: UIView = {
        let panel = UIView()
        panel.backgroundColor = Colors.Weather.Daily.partOfDayBackground
        panel.layer.cornerRadius = 5
        return panel
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        return label
    }()

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular30

        return label
    }()

    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikMedium18
        return label
    }()

    private lazy var feelsLikeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FeelsLike")
        return imageView
    }()

    private lazy var feelsLikeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "По ощущениям"
        return label
    }()

    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        return label
    }()

    private lazy var windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Wind_Dark")
        return imageView
    }()

    private lazy var windTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "Ветер"
        return label
    }()

    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        return label
    }()

    private lazy var uvIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sun")
        return imageView
    }()

    private lazy var uvTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "Уф индекс"
        return label
    }()

    private lazy var uvLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        return label
    }()

    // TODO: Сделать учет времени года, ибо дождик зимой для Сибири не актуально ))
    private lazy var precipitationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Precipitation")
        return imageView
    }()
    
    private lazy var precipitationTitle: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "Осадки"
        return label
    }()
    
    private lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        return label
    }()
    
    private lazy var cloudnessIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cloudness-2")
        return imageView
    }()
    
    private lazy var cloudnessTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular14
        label.text = "Облачность"
        return label
    }()
    
    private lazy var cloudnessLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.rubikRegular18
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(panel)
        panel.snp.makeConstraints { make in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(341)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(15)
            make.top.equalTo(contentView).inset(21)
        }

        let tempStack = UIStackView(arrangedSubviews: [icon, tempLabel])
        tempStack.setCustomSpacing(10, after: icon)
        contentView.addSubview(tempStack)
        tempStack.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).inset(15)
        }
        icon.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

        contentView.addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(tempStack.snp.bottom).inset(-11)
        }

        contentView.addSubview(feelsLikeIcon)
        feelsLikeIcon.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(17)
            make.top.equalTo(conditionLabel.snp.bottom).inset(-25)
            make.width.equalTo(23)
            make.height.equalTo(20)
        }

        contentView.addSubview(feelsLikeTitleLabel)
        feelsLikeTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(feelsLikeIcon.snp.right).inset(-18)
            make.top.equalTo(conditionLabel.snp.bottom).inset(-28)
        }

        contentView.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(20)
            make.top.equalTo(conditionLabel.snp.bottom).inset(-26)
        }

        let separator1 = createSeparator()
        contentView.addSubview(separator1)
        separator1.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(feelsLikeLabel.snp.bottom).inset(-14)
            make.height.equalTo(0.5)
        }

        contentView.addSubview(windIcon)
        windIcon.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(17)
            make.top.equalTo(separator1.snp.bottom).inset(-17)
            make.width.equalTo(24)
            make.height.equalTo(14)
        }

        contentView.addSubview(windTitleLabel)
        windTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(windIcon.snp.right).inset(-18)
            make.top.equalTo(separator1.snp.bottom).inset(-13)
        }

        contentView.addSubview(windLabel)
        windLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(20)
            make.top.equalTo(separator1.snp.bottom).inset(-10)
        }

        let separator2 = createSeparator()
        contentView.addSubview(separator2)
        separator2.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(separator1.snp.bottom).inset(-46)
            make.height.equalTo(0.5)
        }

        contentView.addSubview(uvIcon)
        uvIcon.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(17)
            make.top.equalTo(separator2.snp.bottom).inset(-13)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }

        contentView.addSubview(uvTitleLabel)
        uvTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(windIcon.snp.right).inset(-18)
            make.top.equalTo(separator2.snp.bottom).inset(-13)
        }

        contentView.addSubview(uvLabel)
        uvLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(20)
            make.top.equalTo(separator2.snp.bottom).inset(-10)
        }

        let separator3 = createSeparator()
        contentView.addSubview(separator3)
        separator3.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(separator2.snp.bottom).inset(-46)
            make.height.equalTo(0.5)
        }
        
        contentView.addSubview(precipitationIcon)
        precipitationIcon.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(17)
            make.top.equalTo(separator3.snp.bottom).inset(-8)
            make.width.equalTo(25)
            make.height.equalTo(27)
        }

        contentView.addSubview(precipitationTitle)
        precipitationTitle.snp.makeConstraints { make in
            make.left.equalTo(precipitationIcon.snp.right).inset(-18)
            make.top.equalTo(separator3.snp.bottom).inset(-13)
        }

        contentView.addSubview(precipitationLabel)
        precipitationLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(20)
            make.top.equalTo(separator3.snp.bottom).inset(-10)
        }

        let separator4 = createSeparator()
        contentView.addSubview(separator4)
        separator4.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(separator3.snp.bottom).inset(-46)
            make.height.equalTo(0.5)
        }
        
        contentView.addSubview(cloudnessIcon)
        cloudnessIcon.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(17)
            make.top.equalTo(separator4.snp.bottom).inset(-14)
            make.width.equalTo(24)
            make.height.equalTo(17)
        }

        contentView.addSubview(cloudnessTitleLabel)
        cloudnessTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(precipitationIcon.snp.right).inset(-18)
            make.top.equalTo(separator4.snp.bottom).inset(-13)
        }

        contentView.addSubview(cloudnessLabel)
        cloudnessLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(20)
            make.top.equalTo(separator4.snp.bottom).inset(-10)
        }

        let separator5 = createSeparator()
        contentView.addSubview(separator5)
        separator5.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(separator4.snp.bottom).inset(-46)
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(by partOfDayViewModel: PartOfDayViewModel) {
        titleLabel.text = partOfDayViewModel.name
        icon.download(icon: partOfDayViewModel.icon)
        tempLabel.text = partOfDayViewModel.temp
        conditionLabel.text = partOfDayViewModel.condition
        feelsLikeLabel.text = partOfDayViewModel.feelsLike
        windLabel.text = partOfDayViewModel.wind
        uvLabel.text = partOfDayViewModel.uvIndex
        precipitationLabel.text = partOfDayViewModel.precipitation
        cloudnessLabel.text = partOfDayViewModel.cloudness
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = Colors.Weather.Daily.partOfDaySeparatorColor
        return separator
    }
}
