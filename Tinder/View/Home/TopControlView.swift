//
//  TopControlView.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/8.
//

import UIKit
import RxCocoa
import RxSwift

class TopControlView: UIView {
    
    let tinderButton = createTopButton(imageName: "tinder-selected", unselectedImageName: "tinder-unselected")
    let goodButton = createTopButton(imageName: "good-selected", unselectedImageName: "good-unselected")
    let commentButton = createTopButton(imageName: "comment-selected", unselectedImageName: "comment-unselected")
    let ProfileButton = createTopButton(imageName: "profile-selected", unselectedImageName: "profile-unselected")
    
    static private func createTopButton(imageName: String, unselectedImageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .selected)
        button.setImage(UIImage(named: unselectedImageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    lazy var baseStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, ProfileButton])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 43
        return sv
    }()
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(baseStackView)
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 43, rightPadding: 43)
        tinderButton.isSelected = true
        
        setupBindings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Rx
    private let dispoaseBag = DisposeBag()
    
    private func setupBindings() {
        tinderButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.tinderButton)
            })
            .disposed(by: dispoaseBag)
        
        goodButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.goodButton)
            })
            .disposed(by: dispoaseBag)
        
        commentButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.commentButton)
            })
            .disposed(by: dispoaseBag)
        
        ProfileButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.ProfileButton)
            })
            .disposed(by: dispoaseBag)
    }
    
    private func handleSelectedButton(selectedButton: UIButton) {
        let buttons = [tinderButton, goodButton, commentButton, ProfileButton]
        buttons.forEach { button in
            if button == selectedButton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }

}
