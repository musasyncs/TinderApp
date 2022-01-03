//
//  LoginViewController.swift
//  Tinder
//
//  Created by Ewen on 2021/9/11.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let emailTextField      = RegTextField(placeHolder: "email")
    let passwordTextField   = RegTextField(placeHolder: "password")
    let loginButton         = RegButton(text: "登入")
    let notHadAccountButton = makeAttriTitleButton(text: "我尚未註冊", textStyle: .footnote, fgColor: .white, kern: 0.8)
    
    lazy var sv = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        style()
        layout()
    }
    
    // 按空白部分收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // 登入(email, password)
    private func login() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        AuthManager.shared.loginUser(withEmail: email, password: password) { [weak self] success in
            guard let self = self else { return }
            if success {
                NotificationCenter.default.post(name: K.NotificationName.login, object: nil) // 發送 Notification
            } else {
                let alert = UIAlertController(title: "登入失敗", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確定", style: .cancel, handler: nil))
                self.present(alert, animated: false)
            }
        }
    }
    
}

extension LoginViewController {
    
    private func setupBindings() {
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.login()
            }
            .disposed(by: disposeBag)
        
        notHadAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func style() {
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 20
        
        // GradientLayer
        let layer       = CAGradientLayer()
        let startColor  = UIColor.rgb(red: 255, green: 101, blue: 91).cgColor
        let endColor    = UIColor.rgb(red: 253, green: 41, blue: 123).cgColor
        layer.colors    = [startColor, endColor]
        layer.locations = [0.3, 1.0]
        layer.frame     = view.bounds
        view.layer.addSublayer(layer)
        
        // 防止 Strong password overlay 和 Emoji 輸入
        emailTextField.textContentType = .oneTimeCode
        passwordTextField.textContentType = .oneTimeCode
        emailTextField.keyboardType = .asciiCapable
        passwordTextField.keyboardType = .asciiCapable
    }
    
    func layout() {
        view.addSubview(sv)
        view.addSubview(notHadAccountButton)
        
        emailTextField.anchor(height: 45)
        sv.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, centerY: view.centerYAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        notHadAccountButton.anchor(top: sv.bottomAnchor, centerX: view.centerXAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
