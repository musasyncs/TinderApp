//
//  RegisterViewController.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/9.
//

import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController {

    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField = RegisterTextField(placeHolder: "您的名字")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let registerButton = RegisterButton(text: "登入")
    
    lazy var baseStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 20
        return sv
    }()
    
    func setupGradientLayer() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 288, blue: 108).cgColor
        
        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        
        view.addSubview(titleLabel)
        view.addSubview(baseStackView)
        
        titleLabel.anchor(bottom:baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        nameTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        
//        passwordTextField.isSecureTextEntry = true
        setupBindings()
    }

    //MARK: - Rx
    private let disposeBag = DisposeBag()
    
    private func setupBindings() {
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] in
                
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] in
                
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] in
                
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] in
                // 登入時的處理
                self?.createUserToFireAuth()
            }
            .disposed(by: disposeBag)
    }
    
    private func createUserToFireAuth() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { auth, err in
            
            if let err = err {
                print("auth 情報保存失敗", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            print("auth 情報保存成功: ", uid)
        }
    }
    
    
}
