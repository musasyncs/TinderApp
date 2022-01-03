//
//  HomeViewController.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit
import RxSwift
import FirebaseAuth

class HomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var user: User? //個人的資料
    var users = [User]() //個人以外的使用者們
    var isCardAnimating = false
    
    let cardContainerView = UIView()
    let tabControlView = TabControlView()
    lazy var sv = UIStackView(arrangedSubviews: [cardContainerView, tabControlView])
    let controlView = ControlView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMyself()
        fetchOthers()
        
        tabControlView.tinderButton.isSelected = true
        tabControlView.profileButton.isSelected = false
    }

}

extension HomeViewController {
    
    func setupBindings() {
        // 按重新整理（反悔）
        controlView.reloadView.button.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.fetchOthers()
            }
            .disposed(by: disposeBag)
        
        // 按不喜歡
        controlView.nopeView.button.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                if !self.isCardAnimating, self.cardContainerView.subviews.count != 0 {
                    self.isCardAnimating = true
                    self.cardContainerView.subviews.last?.removeCardViewAnimation(x: -600, completion: {
                        self.isCardAnimating = false
                    })
                }
            }
            .disposed(by: disposeBag)
        
        // 按喜歡
        controlView.likeView.button.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                if !self.isCardAnimating, self.cardContainerView.subviews.count > 0 {
                    self.isCardAnimating = true
                    self.cardContainerView.subviews.last?.removeCardViewAnimation(x: 600, completion: {
                        self.isCardAnimating = false
                    })
                }
            }
            .disposed(by: disposeBag)
        
        // 按個人資訊Tab
        tabControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let profileVC = ProfileViewController()
                profileVC.user = self?.user // 傳 user
                self?.present(profileVC, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    func style() {
        view.backgroundColor = .white
        sv.axis = .vertical
    }
    
    func layout() {
        view.addSubview(sv)
        view.addSubview(controlView)
        
        sv.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        tabControlView.anchor(height: 25)
        controlView.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, height: 50, padding: .init(top: 0, left: 0, bottom: 95, right: 0))
    }
    
    // 讀取個人資料
    func fetchMyself() {
        guard let uid = AuthManager.shared.getCurrentUid() else { return }
        UserManager.shared.fetchMyself(uid: uid) { user in
            self.user = user
        }
    }
    
    // 讀取個人以外使用者的資料
    func fetchOthers() {
        UserManager.shared.fecthOthers { users in
            self.users = users
            
            self.cardContainerView.subviews.forEach({
                $0.removeFromSuperview()
                $0.removeConstraints($0.constraints)
            })
            self.users.forEach { user in
                let cardView = CardView(user: user)
                self.cardContainerView.addSubview(cardView)
                cardView.anchor(
                    top: self.cardContainerView.topAnchor,
                    leading: self.cardContainerView.leadingAnchor,
                    bottom: self.cardContainerView.bottomAnchor,
                    trailing: self.cardContainerView.trailingAnchor,
                    padding: .init(top: 0, left: 0, bottom: 20, right: 0)
                )
            }
        }
    }

}
