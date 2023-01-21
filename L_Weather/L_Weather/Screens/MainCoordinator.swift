
import UIKit

protocol Coordinator {
    func start()
}

final class MainCoordinator : Coordinator {
    
    private let window: UIWindow
    
    init (window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
    }
}
