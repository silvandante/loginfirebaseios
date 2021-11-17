//
//  SingleMovieViewController.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 14/11/21.
//

import UIKit
import SwiftUI

class SingleMovieViewController: UIViewController {
    
    @IBOutlet weak var theContainer: UIView!

    @IBOutlet weak var label: UILabel!
    var movie: Movie?
    
    convenience init() {
        self.init(movie: nil)
    }
        
    init(movie: Movie?) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else {
            return
        }
        
        title = movie.title
        
        let childView = UIHostingController(rootView: SingleMovieUIView(movie: movie))
        
        addChild(childView)
        
        childView.view.frame = theContainer.bounds
        
        theContainer.addSubview(childView.view)
    }
   
}
