//
//  RegTextField.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit

class RegTextField: UITextField {
    init(placeHolder: String) {
        super.init(frame: .zero)
        placeholder             = placeHolder
        borderStyle             = .roundedRect
        font                    = .systemFont(ofSize: 14)
        autocapitalizationType  = .none
        leftViewMode            = .always
        leftView                = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        if placeHolder == "password" {
            isSecureTextEntry = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
