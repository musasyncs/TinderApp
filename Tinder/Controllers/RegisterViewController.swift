//
//  RegisterViewController.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit
import RxSwift

class RegisterViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = RegiserViewModel()
    
    let titleLabel = RegTitleLabel(text: "Tinder")
    let nameTextField = RegTextField(placeHolder: "名字")
    let emailTextField = RegTextField(placeHolder: "email")
    let passwordTextField = RegTextField(placeHolder: "password")
    let passwordConfTextField = RegTextField(placeHolder: "請再次輸入密碼")
    let registerButton = RegButton(text: "註冊")
    let hadAccountButton = makeAttriTitleButton(text: "我已有帳號", textStyle: .footnote, fgColor: .white, kern: 0.8)
    
    lazy var sv = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, passwordConfTextField, registerButton])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // 按空白部分收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // 註冊（email, password）及個人資料保存（uid, name, email）
    private func signupAndCreateRegData() {
        guard let email             = emailTextField.text, !email.isEmpty,
              let password          = passwordTextField.text, !password.isEmpty,
              let name              = nameTextField.text, !name.isEmpty,
              let passwordComfirm   = passwordConfTextField.text, !passwordComfirm.isEmpty else {
                  print("invalid form!")
                  return
              }
        
        guard password == passwordComfirm else {
            print("password incorrect!")
            return
        }
        
        AuthManager.shared.signupNewUser(name: name, email: email, password: password) { [weak self] success in
            if success {
                NotificationCenter.default.post(name: K.NotificationName.login, object: nil) // 發送 Notification
            } else {
                let alert = UIAlertController(title: "註冊失敗", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確定", style: .cancel, handler: nil))
                self?.present(alert, animated: false)
            }
        }
    }
    
}

extension RegisterViewController {
    
    func setupBindings() {
        // text field 的 binding
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        // button 的 binding
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.signupAndCreateRegData()
            }
            .disposed(by: disposeBag)
        
        hadAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let loginVC = LoginViewController()
                self?.navigationController?.pushViewController(loginVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        // view model 的 binding
        viewModel.validRegisterDriver
            .drive { [weak self] allValid in
                self?.registerButton.isEnabled = allValid
                self?.registerButton.backgroundColor = allValid ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
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
        nameTextField.textContentType = .oneTimeCode
        emailTextField.textContentType = .oneTimeCode
        passwordTextField.textContentType = .oneTimeCode
        passwordConfTextField.textContentType = .oneTimeCode
        nameTextField.keyboardType = .asciiCapable
        emailTextField.keyboardType = .asciiCapable
        passwordTextField.keyboardType = .asciiCapable
        passwordConfTextField.keyboardType = .asciiCapable
    }
    
    func layout() {
        view.addSubview(sv)
        view.addSubview(titleLabel)
        view.addSubview(hadAccountButton)
        
        titleLabel.anchor(bottom: sv.topAnchor, centerX: view.centerXAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        nameTextField.anchor(height: 45)
        sv.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, centerY: view.centerYAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        hadAccountButton.anchor(top: sv.bottomAnchor, centerX: view.centerXAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
