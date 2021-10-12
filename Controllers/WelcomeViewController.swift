//
//  WelcomeViewController.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 11/10/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateText(textUILabel: labelTitle, text: "👾LoginFirebaseiOS")
    }
    
    func animateText(textUILabel: UILabel, text: String) {
        var offset = 0.00
        
        textUILabel.text = ""
        
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * offset, repeats: false) { (timer) in
                textUILabel.text?.append(letter)
            }
            offset += 1.00
        }
    }
}
