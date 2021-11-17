//
//  ImageLoader.swift
//  LoginFirebaseiOS
//
//  Created by Administrador on 10/11/21.
//

import Foundation
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    
}
