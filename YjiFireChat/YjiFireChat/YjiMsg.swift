//
//  YjiMsg.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import JSQMessagesViewController

class YjiMsg: JSQMessage {
    var messageId: String
    
    init!(messageId: String, senderId: String!, senderDisplayName: String!, date: Date!, text: String!) {
        self.messageId = messageId
        super.init(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
    }
    
    init!(messageId: String, senderId: String!, senderDisplayName: String!, date: Date!, media: JSQMessageMediaData!) {
        self.messageId = messageId
        super.init(senderId: senderId, senderDisplayName: senderDisplayName, date: date, media: media)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.messageId = YjiComonFunc.getMessageId()
        super.init(coder: aDecoder)
    }

}
