//
//  UIImage-Extension.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/8.
//

import UIKit

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
