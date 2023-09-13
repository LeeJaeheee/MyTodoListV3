//
//  ImageExtension.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit

extension UIImageView {
    
    var circleImage: Bool {
        set {
            if newValue {
                self.layer.cornerRadius = 0.5 * self.bounds.size.width
                self.clipsToBounds = true
            } else {
                self.layer.cornerRadius = 0
                self.clipsToBounds = true
            }
        } get {
            return false
        }
    }
    
    func getImageFromURL(from url: String) {
        URLManager.shared.getImage(from: URL(string: url)!) { image in
            DispatchQueue.main.async {
                if let image = image {
                    self.image = image
                } else {
                    print("fail")
                }
            }
        }
    }
    
}
