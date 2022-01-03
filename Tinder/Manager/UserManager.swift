//
//  UserManager.swift
//  Tinder
//
//  Created by Ewen on 2021/12/27.
//

import FirebaseAuth
import FirebaseFirestore

class UserManager {
    static let shared = UserManager()
    
    var myselfListenReg: ListenerRegistration?
    
    // 讀取個人資料
    func fetchMyself(uid: String, completion: @escaping ((User?) -> Void) ) {
        // 抓某 id document 的 dic
        myselfListenReg = Firestore.firestore().collection("users").document(uid).addSnapshotListener { (docSnapshot, error) in
            if let error = error {
                print("個人資料取得失敗：", error)
                completion(nil)
            } else {
                guard let dic = docSnapshot?.data() else { return }
                let user = User(dic: dic)
                completion(user)
                print("個人資料讀取成功")
            }
        }
    }
    
    // 讀取其他使用者資料
     func fecthOthers(completion: @escaping ([User]) -> Void) {
        // 從某 collection 抓每一筆 document 的 dic
        Firestore.firestore().collection("users").getDocuments(completion: { (querySnapshot, error) in
            if let error = error {
                print("其他使用者資料取得失敗：", error)
                completion([User]())
            } else {
                let users = querySnapshot?.documents.map({ (queryDocSnapshot) -> User in
                    let user = User(dic: queryDocSnapshot.data())
                    return user
                })
                let otherUsers = users?.filter({ (user) -> Bool in
                    return user.uid != AuthManager.shared.getCurrentUid()
                })
                print("其他使用者資料讀取成功")
                completion(otherUsers ?? [User]())
            }
        })
    }
    
    
    // 個人註冊資料上傳
    func createRegData(uid: String, name: String, email: String, completion: (() -> Void)? ) {
        let dic = [
            "name" : name,
            "email": email,
            "uid": uid,
            "createdAt": Timestamp()
        ] as [String : Any]
        
        // 上傳或更新某 id document
        Firestore.firestore().collection("users").document(uid).setData(dic) { error in
            if let error = error {
                print("個人註冊資料上傳失敗：", error)
                completion?()
            } else {
                print("個人註冊資料上傳成功")
                completion?()
            }
        }
    }
    
    // 個人檔案資料更新
    func updateUserInfo(dic: [String : Any], completion: (() -> Void)?) {
        guard let uid = AuthManager.shared.getCurrentUid() else { return }
        
        // 更新某 id 的 document 的某些「已存在」欄位
        Firestore.firestore().collection("users").document(uid).updateData(dic) { error in
            if let error = error {
                print("資料更新失敗：", error)
                completion?()
            } else {
                print("資料更新成功")
                completion?()
            }
        }
    }
}



