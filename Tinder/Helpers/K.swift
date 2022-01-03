//
//  K.swift
//  Tinder
//
//  Created by Ewen on 2022/1/2.
//

import Foundation

struct K {
    struct CellID {
        static let InfoCollectionViewCell = "InfoCollectionViewCell"
    }
        
    struct NotificationName {
        static let logout = Notification.Name("Logout")
        static let login = Notification.Name("Login")
    }
    
    struct LocalStorageKey {
        static let hasLoggedIn = "hasLoggedIn"
    }
}
