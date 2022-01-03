//
//  CardImageView.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/9.
//

import UIKit

class CardImageView: UIImageView {
    
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.3, 1.1]
        layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        contentMode = .scaleToFill
        image = UIImage(named: "test-image2")
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
