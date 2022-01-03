//
//  ProfileImageView.swift
//  Tinder
//
//  Created by Ewen on 2021/9/11.
//

import UIKit

class ProfileImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "no-Image")
        contentMode = .scaleAspectFill
        layer.cornerRadius = 150/2
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
