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
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
}
