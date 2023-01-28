
import UIKit

extension UIViewController {
    
    func showInputDialog(title:String,
                         message: String,
                         inputPlaceholder: String? = nil,
                         inputKeyboardType: UIKeyboardType = UIKeyboardType.default,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showQuestionDialog(title:String,
                            message: String,
                            actionHandler: @escaping((_ isOk: Bool) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            actionHandler(true)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { UIAlertAction in
            actionHandler(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
