import UIKit

extension UITextField {
    
    func setPadding(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
