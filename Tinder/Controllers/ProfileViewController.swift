//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Ewen on 2021/9/11.
//

import UIKit
import SDWebImage
import RxSwift
import FirebaseAuth

class ProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var hasChangedImage = false

    var user: User?
    
    private var name = ""
    private var age = ""
    private var residence = ""
    private var hobby = ""
    private var introduction = ""
    private var email = ""
    
    let saveButton = makeAttriTitleButton(text: "儲存", textStyle: .body, fgColor: .rgb(red: 253, green: 41, blue: 123), kern: 0.8)
    let logoutButton = makeAttriTitleButton(text: "登出", textStyle: .body, fgColor: .rgb(red: 253, green: 41, blue: 123), kern: 0.8)
    let profileEditButton = makeProfileEditButton()
    let profileImageView = ProfileImageView()
    let titleLabel = ProfileLabel()
    
    lazy var infoColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize //cell展開
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.isScrollEnabled = false
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: K.CellID.InfoCollectionViewCell)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension ProfileViewController {
    func setup() {
        // 傳過來的 user 取其中的 profileImageUrl，顯示
        if let url = URL(string: user?.profileImageUrl ?? "") {
            profileImageView.sd_setImage(with: url)
        }
        // 傳過來的 user 取其中的 name，顯示
        titleLabel.text = user?.name

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        profileEditButton.addTarget(self, action: #selector(profileEditButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    func style() {
        view.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(saveButton)
        view.addSubview(logoutButton)
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(profileEditButton)
        view.addSubview(infoColletionView)
        
        saveButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, padding: .init(top: 25, left: 40, bottom: 0, right: 0))
        logoutButton.anchor(top: view.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 40))
        
        profileImageView.anchor(top: view.topAnchor, centerX: view.centerXAnchor, width: 150, height: 150, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        titleLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        profileEditButton.anchor(top: profileImageView.topAnchor, trailing: profileImageView.trailingAnchor, width: 40, height: 40)
        
        infoColletionView.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 80, right: 40))
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoColletionView.dequeueReusableCell(withReuseIdentifier: K.CellID.InfoCollectionViewCell, for: indexPath) as! InfoCollectionViewCell
        cell.user = self.user // user 傳給 cell 的user
        setupCellBindings(cell: cell) // 把編輯的內容與同步到 self 的屬性
        return cell
    }

    private func setupCellBindings(cell: InfoCollectionViewCell) {
        cell.nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.name = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.ageTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.age = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.residenceTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.residence = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.hobbyTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.hobby = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.introductionTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.introduction = text ?? ""
            }
            .disposed(by: disposeBag)
        
        cell.emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.email = text ?? ""
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
extension ProfileViewController {
    
    // 點選儲存按鈕（上傳）
    @objc func saveButtonTapped() {
        let dic = [
            "name": self.name,
            "age": self.age,
            "email": self.email,
            "residence": self.residence,
            "hobby": self.hobby,
            "introduction": self.introduction,
            "uid": AuthManager.shared.getCurrentUid()
        ]
        
        // 更新個人資料
        UserManager.shared.updateUserInfo(dic: dic as [String : Any]) {
            let alert = UIAlertController(title: "您的資料已更新", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            self.present(alert, animated: false)
        }
        
        // 若用 image picker 換過頭貼了，就把該頭貼上傳 Storage，字典的 "profileImageUrl" 欄位也更新
        if self.hasChangedImage {
            guard let image = self.profileImageView.image else { return }
            
            PhotoManager.shared.uploadProfileImage(image: image, dic: dic as [String : Any], completion: nil)
        }
        
        // 名字標題更改！
        titleLabel.text = self.name
    }
    
    // 按頭貼編輯按鈕
    @objc func profileEditButtonTapped() {
        let actionSheet = UIAlertController(title: "Add a Photo", message: "Select a source:", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.showImagePickerController(mode: .camera)
            }
            actionSheet.addAction(cameraButton)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                self.showImagePickerController(mode: .photoLibrary)
            }
            actionSheet.addAction(libraryButton)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelButton)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func showImagePickerController(mode: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = mode
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 按登出按鈕
    @objc func logoutButtonTapped() {
        let result = AuthManager.shared.logoutUser()
        switch result {
        case .success:
            NotificationCenter.default.post(name: K.NotificationName.logout, object: nil) // 發送 Notification
        case .failure(let error):
            print("登出失敗: ", error.localizedDescription)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImageView.image = image.withRenderingMode(.alwaysOriginal)
            self.hasChangedImage = true
        }
        picker.dismiss(animated: true)
    }
}
