//
//  YjiComonFunc.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class YjiComonFunc: NSObject {
    static func getUserId() -> String? {
        guard let userId = UserDefaults.standard.object(forKey: UserInfoKey.userId) as? String else {return nil}
        return userId
    }
    
    static func getMessageId() -> String {
        return String(UInt64(Date().timeIntervalSince1970))
    }
    
    static func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }
    
    // TOLEARN
    static func getIconImage(id: String) -> JSQMessagesAvatarImage {
        return JSQMessagesAvatarImageFactory.avatarImage(withPlaceholder: UIImage(named:"jiyun")!, diameter: 20)
    }
    
    static func getConversationId(userId1: String, userId2: String) -> String{
        var arr = [userId1, userId2]
        arr.sort()
        let conId = arr.joined(separator: ",")
        return conId
    }
    
    static func getSQlitePath() -> String? {
        // path document
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let documentPath = paths.first else {
            return nil
        }
        let path = documentPath + "/yjichat.sqlite3"
        return path
    }
    
}
