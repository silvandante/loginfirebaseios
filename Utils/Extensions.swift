//
//  Extensions.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 11/10/21.
//
import UIKit

extension UIButton {
        func loadingIndicator(_ show: Bool) {
            let tag = 808404
            if show {
                self.isEnabled = false
                self.alpha = 0.5
                let indicator = UIActivityIndicatorView()
                let buttonHeight = self.bounds.size.height
                let buttonWidth = self.bounds.size.width
                indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
                indicator.tag = tag
                self.addSubview(indicator)
                indicator.startAnimating()
            } else {
                self.isEnabled = true
                self.alpha = 1.0
                if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                }
            }
        }
}
