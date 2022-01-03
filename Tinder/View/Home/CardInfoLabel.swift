//
//  CardInfoLabel.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/9.
//

import UIKit

class CardInfoLabel: UILabel {
    
    // goodLabel / nopeLabel
    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 45)
        self.text = text
        self.textColor = textColor

        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = textColor.cgColor
        
        textAlignment = .center
        alpha = 0
    }
    
    // residenceLabel / hobbyLabel / introductionLabel
    init(text: String, font: UIFont) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
