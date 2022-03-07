import UIKit

extension UINavigationBar {

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 1000.0)
    }

}
