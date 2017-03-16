//
//  YjiSQliteManager.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit
import SQLite

class YjiSQliteManager: NSObject {
    
    var db: Connection!
    var table_chats: Table!
    
    class var sharedInstance: YjiSQliteManager {
        struct Static {
            static let instance: YjiSQliteManager = YjiSQliteManager()
        }
        return Static.instance
    }
    
    func creatDB() {
        guard db == nil else {
            return
        }
        guard let sqlitePath = YjiComonFunc.getSQlitePath() else {
            return
        }
        do {
            db = try Connection(sqlitePath)
            table_chats = Table("Chats")
            // TOLEARN
            let targetUserId = Expression<String>("targetUserId")
            let lastMessageTime = Expression<String>("lastMessageTime")
            let lastMessage = Expression<String>("lastMessage")
            let query = table_chats.create(block: { (table) in
                table.column(targetUserId, primaryKey: true)
                table.column(lastMessageTime)
                table.column(lastMessage)
            })
            try db.run(query)
            
        } catch {
            print("DB Error")
        }
    }
    
    func insertChat(info: YjiUserDT) {
        if table_chats == nil {
            return
        }
        do {
            let statement = try db.prepare("insert into Chats (targetUserId, lastMessageTime, lastMessage) values (?, ?, ?)")
            try statement.run([info.userId, info.lastMessageTime.value, info.lastMessage.value])
            print("success to insert local DB")
        } catch {
            print("fail to insert local DB")
        }
    }
    
    func getLastMessageTime(targetUserId: String) -> String? {
        do {
            for row in try db.prepare("select from Chats where targetUserId = \(targetUserId)") {
                guard let lastMessageTime = row[1] as? String else {
                    continue
                }
                return lastMessageTime
            }
        } catch {
            print("fail to get data.")
        }
        return nil
    }
    

}
