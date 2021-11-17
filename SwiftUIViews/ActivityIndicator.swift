//
//  ActivityIndicator.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 10/11/21.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) { }
    
}
