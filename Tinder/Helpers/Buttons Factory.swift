//
//  Buttons Factory.swift
//  Tinder
//
//  Created by Ewen on 2021/12/27.
//

import UIKit

// MARK: - Buttons

func makeAttriTitleButton(text: String, textStyle: UIFont.TextStyle, fgColor: UIColor, kern: Double) -> UIButton {
    let button = UIButton(type: .custom)
    let attributedText = NSMutableAttributedString(string: text, attributes: [
        .font: UIFont.preferredFont(forTextStyle: textStyle),
        .foregroundColor: fgColor,
        .kern: kern
    ])
    button.setAttributedTitle(attributedText, for: .normal)
    return button
}

// For ProfileViewController
func makeProfileEditButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
    button.imageView?.contentMode = .scaleToFill
    
    button.layer.cornerRadius = 40/2
    button.layer.borderWidth = 0.3
    button.layer.borderColor = UIColor.darkGray.cgColor
    
    button.backgroundColor = .white
    button.tintColor = .darkGray
    return button
}


// For TabControlView
func makeTabButton(imageName: String, unselectedImageName: String) -> UIButton {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: imageName), for: .selected)
    button.setImage(UIImage(named: unselectedImageName), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    return button
}

// For CardView
func makeInfoButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "info.circle.fill")?.resize(to: .init(width: 16, height: 16)), for: .normal)
    button.imageView?.contentMode     = .scaleAspectFit
    button.contentEdgeInsets          = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    button.tintColor                  = .white
    return button
}

func makeHobbyButton() -> UIButton {
    let button = UIButton(type: .system)
    button.titleLabel?.font           = .systemFont(ofSize: 20, weight: .medium)
    button.layer.cornerRadius         = 32/2
    button.contentEdgeInsets          = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    button.tintColor                  = .white
    button.isUserInteractionEnabled   = false
    return button
}
