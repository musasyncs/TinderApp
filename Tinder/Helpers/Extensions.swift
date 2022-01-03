//
//  Extensions.swift
//  Tinder
//
//  Created by Ewen on 2022/1/2.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return .init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    static let reloadColor      = UIColor.rgb(red: 254, green: 207, blue: 102)
    static let nopeColor        = UIColor.rgb(red: 250, green: 81, blue: 102)
    static let superLikeColor   = UIColor.rgb(red: 62, green: 176, blue: 254)
    static let likeColor        = UIColor.rgb(red: 35, green: 229, blue: 177)
    static let boostColor       = UIColor.rgb(red: 196, green: 89, blue: 246)
    
}

extension UIImage {
    func resize(to goalSize: CGSize) -> UIImage? {
        let widthRatio = goalSize.width / size.width
        let heightRatio = goalSize.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: resizedSize))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

extension UIView {
    // Card drop animations
    func removeCardViewAnimation(x: CGFloat, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
            self.transform = CGAffineTransform(rotationAngle: (x/30) * .pi / 180).translatedBy(x: x, y: 100)
            self.layoutIfNeeded()
        } completion: { _ in
            self.removeFromSuperview()
            completion?()
        }
    }
    
    func fillSuperView() {
        anchor(
            top: superview?.topAnchor,
            leading: superview?.leadingAnchor,
            bottom: superview?.bottomAnchor,
            trailing: superview?.trailingAnchor
        )
    }
    
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        padding: UIEdgeInsets = .zero
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
