//
//  TopControlView.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit

class TabControlView: UIView {
    let tinderButton = makeTabButton(imageName: "tinder-selected", unselectedImageName: "tinder-unselected")
    let goodButton = makeTabButton(imageName: "good-selected", unselectedImageName: "good-unselected")
    let commentButton = makeTabButton(imageName: "comment-selected", unselectedImageName: "comment-unselected")
    let profileButton = makeTabButton(imageName: "profile-selected", unselectedImageName: "profile-unselected")
    lazy var sv = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabControlView {
    func setup() {
        tinderButton.addTarget(self, action: #selector(tinderButtonTapped), for: .touchUpInside)
        goodButton.addTarget(self, action: #selector(goodButtonTapped), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    func style() {
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 55
    }
    
    func layout() {
        addSubview(sv)
        sv.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 25, bottom: 0, right: 25)
        )
    }
}

// MARK: - Actions
extension TabControlView {
    @objc func tinderButtonTapped() {
        self.handleSelectedButton(selectedButton: self.tinderButton)
    }
    @objc func goodButtonTapped() {
        self.handleSelectedButton(selectedButton: self.goodButton)
    }
    @objc func commentButtonTapped() {
        self.handleSelectedButton(selectedButton: self.commentButton)
    }
    @objc func profileButtonTapped() {
        self.handleSelectedButton(selectedButton: self.profileButton)
    }
    
    private func handleSelectedButton(selectedButton: UIButton) {
        let buttons = [tinderButton, goodButton, commentButton, profileButton]
        buttons.forEach { button in
            if button == selectedButton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}
