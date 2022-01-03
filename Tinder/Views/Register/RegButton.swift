//
//  RegButton.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit

class RegButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? .rgb(red: 227, green: 48, blue: 78, alpha: 0.2) : .rgb(red: 227, green: 48, blue: 78)
        }
    }
    init(text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor     = .rgb(red: 227, green: 48, blue: 78)
        layer.cornerRadius  = 10
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
