//
//  LoginViewController.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 11/10/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var enterButton: UIButton!

    @IBAction func onEnterClick(_ sender: Any) {
        enterButton.loadingIndicator(true)
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Warning!", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                            case .default:
                            print("default")
                            
                            case .cancel:
                            print("cancel")
                            
                            case .destructive:
                            print("destructive")
                            
                        @unknown default:
                            print("Not known error")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.enterButton.loadingIndicator(false)
                } else {
                    self.performSegue(withIdentifier: "fromLoginToDashboard", sender: self)
                }
            }
        }
    }
    
}
