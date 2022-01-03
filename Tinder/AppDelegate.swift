//
//  AppDelegate.swift
//  Tinder
//
//  Created by Ewen on 2021/9/10.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let registerVC = RegisterViewController()
    let homeVC = HomeViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        // 設定 Notification
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: K.NotificationName.login, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: K.NotificationName.logout, object: nil)
        
        // 跳轉
        if LocalStorage.shared.hasLoggedIn {
            let homeNav = UINavigationController(rootViewController: homeVC)
            setRootViewController(homeNav)
        } else {
            let regNav = UINavigationController(rootViewController: registerVC)
            setRootViewController(regNav)
        }
        
        return true
    }
    
    private func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }

}


// MARK: - Notification - didLogin
extension AppDelegate {
    @objc func didLogin() {
        LocalStorage.shared.hasLoggedIn = true
        let homeNav = UINavigationController(rootViewController: homeVC)
        setRootViewController(homeNav)
    }
}

// MARK: - Notification - didLogout
extension AppDelegate {
    @objc func didLogout() {
        LocalStorage.shared.hasLoggedIn = false
        let regNav = UINavigationController(rootViewController: registerVC)
        setRootViewController(regNav)
    }
}
