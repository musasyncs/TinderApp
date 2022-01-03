//
//  RegisterTextField.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/10.
//

import UIKit

class RegisterTextField: UITextField {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        placeholder = placeHolder
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
