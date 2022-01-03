//
//  ControlView+ControlButtonView+ControlButton.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit

class ControlView: UIView {
    let reloadView = ControlButtonView(frame: .zero, buttonWidth: 45, imageName: "reload", borderColor: .reloadColor)
    let nopeView = ControlButtonView(frame: .zero, buttonWidth: 62, imageName: "nope", borderColor: .nopeColor)
    let superlikeView = ControlButtonView(frame: .zero, buttonWidth: 45, imageName: "superlike", borderColor: .superLikeColor)
    let likeView = ControlButtonView(frame: .zero, buttonWidth: 62, imageName: "like", borderColor: .likeColor )
    let boostview = ControlButtonView(frame: .zero, buttonWidth: 45, imageName: "boost", borderColor: .boostColor)
    lazy var sv = UIStackView(arrangedSubviews: [reloadView, nopeView, superlikeView, likeView, boostview])

    override init(frame: CGRect) {
        super.init(frame: frame)
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        
        addSubview(sv)
        sv.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ControlButtonView: UIView {
    var button = ControlButton(type: .custom)
    
    init(frame: CGRect, buttonWidth: CGFloat, imageName: String, borderColor: UIColor) {
        super.init(frame: frame)
        switch imageName {
        case "reload":
            button.setImage(UIImage(named: imageName)?.resize(to: CGSize(width: buttonWidth * 0.4, height: buttonWidth * 0.4)), for: .normal)
        case "nope":
            button.setImage(UIImage(named: imageName)?.resize(to: CGSize(width: buttonWidth * 0.4, height: buttonWidth * 0.4)), for: .normal)
        case "superlike":
            button.setImage(UIImage(named: imageName)?.resize(to: CGSize(width: buttonWidth * 0.45, height: buttonWidth * 0.45)), for: .normal)
        case "like":
            button.setImage(UIImage(named: imageName)?.resize(to: CGSize(width: buttonWidth * 0.45, height: buttonWidth * 0.45)), for: .normal)
        case "boost":
            button.setImage(UIImage(named: imageName)?.resize(to: CGSize(width: buttonWidth * 0.5, height: buttonWidth * 0.5)), for: .normal)
        default:
            break
        }
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = buttonWidth/2
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = 2
        
        addSubview(button)
        button.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: buttonWidth, height: buttonWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ControlButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }
}
