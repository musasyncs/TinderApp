//
//  InfoCollectionViewCell.swift
//  Tinder
//
//  Created by Ewen on 2021/9/11.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            nameTextField.text          = user?.name
            ageTextField.text           = user?.age
            residenceTextField.text     = user?.residence
            hobbyTextField.text         = user?.hobby
            introductionTextField.text  = user?.introduction
            emailTextField.text         = user?.email
        }
    }
    
    let nameLabel               = ProfileLabel(title: "名字")
    let ageLabel                = ProfileLabel(title: "年齢")
    let residenceLabel          = ProfileLabel(title: "居住地")
    let hobbyLabel              = ProfileLabel(title: "興趣")
    let introductionLabel       = ProfileLabel(title: "自我介紹")
    let emailLabel              = ProfileLabel(title: "email")
    
    let nameTextField           = ProfileTextField(placeholder: "名字")
    let ageTextField            = ProfileTextField(placeholder: "年齢")
    let residenceTextField      = ProfileTextField(placeholder: "居住地")
    let hobbyTextField          = ProfileTextField(placeholder: "興趣")
    let introductionTextField   = ProfileTextField(placeholder: "自我介紹")
    let emailTextField          = ProfileTextField(placeholder: "email")
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        // setup
        let pairs = [
            [nameLabel, nameTextField],
            [ageLabel, ageTextField],
            [residenceLabel, residenceTextField],
            [hobbyLabel, hobbyTextField],
            [introductionLabel, introductionTextField],
            [emailLabel, emailTextField]
        ]
        let pairSVs = pairs.map { (pair) -> UIStackView in
            guard let label = pair.first as? UILabel,
                  let textField = pair.last as? UITextField else { return UIStackView() }
            let pairSV = UIStackView(arrangedSubviews: [label, textField])
            pairSV.axis = .vertical
            pairSV.spacing = 5
            textField.textColor = .black
            textField.anchor(height: 45)
            return pairSV
        }
        let sv = UIStackView(arrangedSubviews: pairSVs)
        
        // style
        backgroundColor = .white
        sv.axis = .vertical
        sv.spacing = 15
        
        // layout
        addSubview(sv)
        sv.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, centerX: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        nameTextField.anchor(width: UIScreen.main.bounds.width-80)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - ProfileLabel
class ProfileLabel: UILabel {
    // 名字大標題使用
    init() {
        super.init(frame: .zero)
        font        = .systemFont(ofSize: 30, weight: .bold)
        textColor   = .black
    }
    
    // Cell的小標題使用
    init(title: String) {
        super.init(frame: .zero)
        text        = title
        textColor   = .darkGray
        font        = .systemFont(ofSize: 14)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - ProfileTextField
class ProfileTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        borderStyle = .roundedRect
        self.placeholder = placeholder
        if placeholder == "email" {
            isUserInteractionEnabled = false
            backgroundColor = .rgb(red: 233, green: 233, blue: 233)
        } else {
            backgroundColor = .rgb(red: 245, green: 245, blue: 245)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
