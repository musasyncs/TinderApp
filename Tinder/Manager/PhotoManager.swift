//
//  PhotoManager.swift
//  Tinder
//
//  Created by Ewen on 2021/12/27.
//

import FirebaseStorage

class PhotoManager {
    static let shared = PhotoManager()
    
    // 個人頭貼上傳 Storage，更新個人資料
    func uploadProfileImage(image: UIImage, dic: [String: Any], completion: (() -> Void)?) {
        
        let filename = NSUUID().uuidString
        let path = Storage.storage().reference().child("profile_image").child(filename)
        
        guard let imgData = image.jpegData(compressionQuality: 0.3) else { return }
        
        path.putData(imgData, metadata: nil) { (_, error) in
            if let error = error {
                print("個人頭貼上傳失敗：", error)
                completion?()
            } else {
                path.downloadURL { (url, error) in
                    if let error = error {
                        print("頭貼 url 下載失敗：", error)
                        return
                    }
                    var dic = dic
                    dic["profileImageUrl"] = url?.absoluteString
                    
                    UserManager.shared.updateUserInfo(dic: dic, completion: nil)
                    completion?()
                }
            }
        }
    }
    
}
