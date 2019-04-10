//
//  YjiUserDT.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit
import RxSwift

class YjiUserDT: NSObject {
    var userId: String
    var userName: String
    var imageUrl: String
    var lastMessage = Variable("")
    var lastMessageTime = Variable("now")
    var isReaded = Variable(false)
    
    init(userId: String, userName: String, imageUrl: String) {
        self.userId = userId
        self.userName = userName
        self.imageUrl = imageUrl
    }

}
