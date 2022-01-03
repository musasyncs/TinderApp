//
//  BottomControlView.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/8.
//

import UIKit

class BottomControlView: UIView {
    
    let reloadView = BottomButtonView(frame: .zero, buttonWidth: 50, imageName: "reload")
    let nopeView = BottomButtonView(frame: .zero, buttonWidth: 60, imageName: "nope")
    let superlikeView = BottomButtonView(frame: .zero, buttonWidth: 50, imageName: "superlike")
    let likeView = BottomButtonView(frame: .zero, buttonWidth: 60, imageName: "like")
    let boostview = BottomButtonView(frame: .zero, buttonWidth: 50, imageName: "boost")
    
    lazy var baseStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [reloadView, nopeView, superlikeView, likeView, boostview])
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.spacing = 10
        return v
    }()
     
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(baseStackView)
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BottomButtonView: UIView {
    
    func createButton(buttonWidth: CGFloat, imageName: String) {
        let b = BottomButton(type: .custom)
        b.setImage(UIImage(named: imageName)?.resize(to: CGSize(width: buttonWidth * 0.4, height: buttonWidth * 0.4)), for: .normal)
        b.backgroundColor = .white
        b.layer.cornerRadius = buttonWidth / 2
        b.layer.shadowOffset = .init(width: 1.5, height: 2) // 記
        b.layer.shadowColor = UIColor.black.cgColor // 記
        b.layer.shadowOpacity = 0.3 // 記
        b.layer.shadowRadius = 1 // 記
        
        addSubview(b)
        b.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: buttonWidth, height: buttonWidth)
    }
    
    
    // MARK: - init
    init(frame: CGRect, buttonWidth: CGFloat, imageName: String) {
        super.init(frame: frame)
        createButton(buttonWidth: buttonWidth, imageName: imageName)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
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
