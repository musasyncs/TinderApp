//
//  CardView.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit
import SDWebImage

class CardView: UIView {
    let cardImageView = CardImageView(frame: .zero)
    let likeLabel = CardInfoLabel(text: "LIKE", textColor: .rgb(red: 61, green: 196, blue: 197))
    let nopeLabel = CardInfoLabel(text: "NOPE", textColor: .rgb(red: 251, green: 86, blue: 101))
    
    let nameLabel = CardInfoLabel(font: .systemFont(ofSize: 40, weight: .semibold))
    let ageLabel = CardInfoLabel(font: .systemFont(ofSize: 26, weight: .regular))
    let infoButton = makeInfoButton()
    lazy var nameAgeInfoSV = UIStackView(arrangedSubviews: [nameLabel, ageLabel, infoButton])
    
    let hobbyButton = makeHobbyButton()
    let introLabel = CardInfoLabel(font: .systemFont(ofSize: 20, weight: .regular))
    
    init(user: User) {
        super.init(frame: .zero)
        setup(user: user)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardView {
    func setup(user: User) {
        // 資料顯示
        nameLabel.text = user.name
        ageLabel.text = user.age
        hobbyButton.backgroundColor = .rgb(red: 251, green: 86, blue: 101)
        hobbyButton.setTitle(user.hobby, for: .normal)
        introLabel.text = user.introduction
        if let url = URL(string: user.profileImageUrl) {
            cardImageView.sd_setImage(with: url)
        }
        
        // gesture
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCardView)))
    }
    
    func style() {
        nameAgeInfoSV.axis = .horizontal
        nameAgeInfoSV.spacing = 10
        nameAgeInfoSV.alignment = .lastBaseline
    }
    
    func layout() {
        addSubview(cardImageView)
        addSubview(nameAgeInfoSV)
        addSubview(hobbyButton)
        addSubview(introLabel)
        addSubview(likeLabel)
        addSubview(nopeLabel)
        
        cardImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 2, bottom: 0, right: 2))
        introLabel.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, height: 35, padding: .init(top: 0, left: 20, bottom: 100, right: 22))
        hobbyButton.anchor(leading: leadingAnchor, bottom: introLabel.topAnchor, height: 32, padding: .init(top: 0, left: 22, bottom: 3, right: 0))
        nameAgeInfoSV.anchor(leading: leadingAnchor, bottom: hobbyButton.topAnchor, padding: .init(top: 0, left: 22, bottom: 10, right: 0))
        likeLabel.anchor(top: cardImageView.topAnchor, leading: cardImageView.leadingAnchor, width: 135, height: 65, padding: .init(top: 60, left: 40, bottom: 0, right: 0))
        likeLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-25) * .pi/180)
        
        nopeLabel.anchor(top: cardImageView .topAnchor, trailing: cardImageView.trailingAnchor, width: 165, height: 65, padding: .init(top: 60, left: 0, bottom: 0, right: 40))
        nopeLabel.transform = CGAffineTransform(rotationAngle: CGFloat(25) * .pi/180)
    }
}

// Actions
extension CardView {
    @objc func panCardView(sender: UIPanGestureRecognizer) {
        guard let card = sender.view else { return }
        let trans = sender.translation(in: self)
        
        switch sender.state {
        case .began:
            break
        case .changed:
//            print("changed:\(trans)")
            self.handlePanChange(trans: trans)
        case .ended:
//            print("ended:\(trans)")
            self.handlePanEnded(view: card, translation: trans)
        default:
            break
        }
    }
    
    private func handlePanChange(trans: CGPoint) {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(-trans.x / 10) * .pi / 180).translatedBy(x: trans.x, y: trans.y)
        if trans.x > 0 {
            self.likeLabel.alpha = 1/100 * trans.x
        } else if trans.x < 0 {
            self.nopeLabel.alpha = -1/100 * trans.x
        }
    }
    
    private func handlePanEnded(view: UIView, translation: CGPoint) {
        if translation.x <= -150 {
            view.removeCardViewAnimation(x: -600)
        } else if translation.x >= 150 {
            view.removeCardViewAnimation(x: 600)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                self.transform = .identity
                self.layoutIfNeeded()
                self.likeLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }
    }
}


// MARK: - Sub - CardImageView
class CardImageView: UIImageView {
    private let gradientLayer = CAGradientLayer()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor     = .darkGray
        layer.cornerRadius  = 10
        contentMode         = .scaleAspectFill
        clipsToBounds       = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
    }
}


// MARK: - Sub - CardInfoLabel
class CardInfoLabel: UILabel {
    // likeLabel / nopeLabel
    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        font                = .boldSystemFont(ofSize: 50)
        self.text           = text
        self.textColor      = textColor
        alpha               = 0
        textAlignment       = .center
        layer.cornerRadius  = 10
        layer.borderWidth   = 5
        layer.borderColor   = textColor.cgColor
    }
    
    // nameLabel / ageLabel / introLabel
    init(font: UIFont) {
        super.init(frame: .zero)
        self.font = font
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
