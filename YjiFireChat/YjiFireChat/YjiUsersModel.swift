//
//  YjiUsersModel.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit
import Firebase

class YjiUsersModel: NSObject {
    
    var users = [YjiUserDT]()
    let ref = Database.database().reference()
    
    func getUsers(completion: @escaping (String?) -> Void) {
        ref.child("Users").observe(.value, with: { [weak self] (snapshot) in
            guard let dict = snapshot.value as? [String : Any] else {
                return completion("can not find data from fire base")
            }
            let sortedDic = dict.sorted(by: { (o1, o2) -> Bool in
                return o1.key < o2.key
            })
            self?.users.removeAll()
            
            for info in sortedDic {
                let userId = info.key
                if let curUserId = YjiComonFunc.getUserId(), userId == curUserId {
                    continue
                }
                guard let userDic = info.value as? NSDictionary else {continue}
                guard let userName = userDic[UserInfoKey.userName] as? String else {continue}
                guard let imageUrl = userDic[UserInfoKey.imageUrl] as? String else {continue}

                let user = YjiUserDT(userId: userId, userName: userName, imageUrl: imageUrl)
                self?.users.append(user)
                
            }
            return completion(nil)
        })
    }
    
    func setListener() {
        ref.observe(.value, with: { (snapshot) in
            guard let dict = snapshot.value as? [String : Any] else {
                return
            }
            
            let sortedDic = dict.sorted(by: { (o1, o2) -> Bool in
                return o1.key < o2.key
            })
            
            for info in sortedDic {
                let conversationId = info.key
                if !conversationId.contains(",") {
                    continue
                }
                guard let messages = info.value as? [String: Any] else {
                    print("have no message.")
                    continue
                }
                let sortedDic = messages.sorted(by: { (o1, o2) -> Bool in
                    return o1.key < o2.key
                })
                guard let info = sortedDic.last else {
                    print("have no message.")
                    continue
                }
                guard let msgDic = info.value as? NSDictionary else {
                    print("have no message dic.")
                    continue
                }
                guard let msg = msgDic["content"] as? String else {
                    print("no message string.")
                    continue
                }
                guard let dateTime = msgDic["time"] as? String else {
                    print("no time string.")
                    continue
                }
                var time = (dateTime as NSString).substring(from: 11)
                time = (time as NSString).substring(to: 5)
                
                for targetUser in self.users {
                    if conversationId.contains(targetUser.userId) {
                        targetUser.lastMessage.value = msg
                        if let lastMsg = YjiSQliteManager.sharedInstance.getLastMessageTime(targetUserId: targetUser.userId) {
                            targetUser.isReaded.value = lastMsg == time
                        }
                        targetUser.lastMessageTime.value = time
                        break
                    }
                }
                
            }
            
        })
    }
    
}
