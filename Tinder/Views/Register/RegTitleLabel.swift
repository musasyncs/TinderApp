//
//  RegTitleLabel.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit

class RegTitleLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text       = text
        self.font       = .boldSystemFont(ofSize: 50)
        self.textColor  = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
