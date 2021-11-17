//
//  DashboardViewController.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 11/10/21.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func onLogoutClick(_ sender: Any) {
        logoutButton.loadingIndicator(true)
        do {
            try Auth.auth().signOut()
            
            logoutButton.loadingIndicator(false)
            
            navigationController?.popToRootViewController(animated: true)
        
        } catch let signOutError as NSError {
            let alert = UIAlertController(title: "Warning!", message: signOutError.localizedDescription, preferredStyle: .alert)
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
            logoutButton.loadingIndicator(false)
        }
    }
    
}
