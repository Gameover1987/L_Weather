
import UIKit

class CustomButton: UIButton {
    
    private let buttonAction: () -> ()
    
    init(action: @escaping () -> (), color: UIColor, title: String, titleColor: UIColor, font: UIFont) {
        self.buttonAction = action
        super.init(frame: .zero)
        
        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        
        layer.cornerRadius = 10
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton() {
        buttonAction()
    }
}
