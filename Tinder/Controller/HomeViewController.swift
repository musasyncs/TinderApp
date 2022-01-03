//
//  HomeViewController.swift
//  MatchApp
//
//  Created by Ewen on 2021/9/8.
//

import UIKit

class HomeViewController: UIViewController {
    
    let topControlView = TopControlView()
    let cardView = CardView()
    let bottomControlView = BottomControlView()
    
    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        v.axis = .vertical
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor
        )
        topControlView.anchor(height: 100)
        bottomControlView.anchor(height: 120)
    }
}

