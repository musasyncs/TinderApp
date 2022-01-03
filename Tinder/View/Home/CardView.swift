//
//  CardView.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/9.
//

import UIKit

class CardView: UIView {
    
    private let cardImageView = CardImageView(frame: .zero)
    
    private let goodLabel = CardInfoLabel(text: "GOOD", textColor: .rgb(red: 137, green: 223, blue: 86))
    private let nopeLabel = CardInfoLabel(text: "NOPE", textColor: .rgb(red: 222, green: 110, blue: 110))
    
    private let residenceLabel = CardInfoLabel(text: "臺北，臺灣", font: .systemFont(ofSize: 20, weight: .regular))
    private let hobbyLabel = CardInfoLabel(text: "音樂", font: .systemFont(ofSize: 25, weight: .regular))
    private let introductionLabel = CardInfoLabel(text: "沒什麼好說的", font: .systemFont(ofSize: 25, weight: .regular))
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    private let nameLabel = CardInfoLabel(text: "Ewen, 20", font: .systemFont(ofSize: 40, weight: .heavy))
    
    lazy var infoVerticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        sv.axis = .vertical
        return sv
    }()
    
    lazy var baseStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        sv.axis = .horizontal
        return sv
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UI
        addSubview(cardImageView)
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        
        addSubview(baseStackView)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        infoButton.anchor(width: 40)
        
        addSubview(nameLabel)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        
        addSubview(goodLabel)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55,  topPadding: 25, leftPadding: 20)
        
        addSubview(nopeLabel)
        nopeLabel.anchor(top: cardImageView .topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 20)

        
        
        // gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // gesture 
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        if gesture.state == .changed {
            self.handlePanChange(translation: translation)
            
        } else if gesture.state == .ended {
            self.handlePanEnded()
        }
    }
    
    private func handlePanChange(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 100
        
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
//        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        
        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
    }
    
    private func handlePanEnded() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
            self.transform = .identity
            self.layoutIfNeeded()
            
            self.goodLabel.alpha = 0
            self.nopeLabel.alpha = 0
        }
    }
    
}
