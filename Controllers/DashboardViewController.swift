//
//  DashboardViewController.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 11/10/21.
//

import UIKit
import Firebase
import SwiftUI

class DashboardViewController: UIViewController {

    @IBOutlet weak var theContainer: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        title = "Top Movies"
        
        let childView = UIHostingController(rootView: MovieListUIView(_openMovieDetail: openMovieDetail))
        
        addChild(childView)
        
        childView.view.frame = theContainer.bounds
        
        theContainer.addSubview(childView.view)
    }
    
    func openMovieDetail(movie: Movie) {
        let singleMovie = self.storyboard?.instantiateViewController(withIdentifier: "SingleMovieViewController") as! SingleMovieViewController
        singleMovie.movie = movie
        self.navigationController?.pushViewController(singleMovie, animated: true)
    }
    
    
    
    func onLogoutClick() {
        do {
            try Auth.auth().signOut()
            
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
        }
    }
    
}
