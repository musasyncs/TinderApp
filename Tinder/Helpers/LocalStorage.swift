//
//  LocalStorage.swift
//  Tinder
//
//  Created by Ewen on 2022/1/2.
//

import Foundation

class LocalStorage {
    static let shared = LocalStorage()
    
    var hasLoggedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: K.LocalStorageKey.hasLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: K.LocalStorageKey.hasLoggedIn)
        }
    }
}
