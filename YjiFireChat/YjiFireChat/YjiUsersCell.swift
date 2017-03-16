//
//  YjiUsersCell.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit
import RxSwift

class YjiUsersCell: UITableViewCell {

    let iconImageView = UIImageView()
    let userNameLbl = UILabel()
    let chatLbl = UILabel()
    let timeLbl = UILabel()
    let unreadView = UIView()
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(iconImageView)
        iconImageView.layer.cornerRadius = 30
        iconImageView.layer.masksToBounds = true
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.top.left.equalTo(24)
        }
        
        unreadView.backgroundColor = UIColor.red
        unreadView.clipsToBounds = true
        unreadView.layer.cornerRadius = 6
        unreadView.layer.masksToBounds = true
        self.addSubview(unreadView)
        unreadView.snp.makeConstraints { (make) in
            make.width.height.equalTo(12)
            make.top.left.equalTo(24)
        }
        
        userNameLbl.textColor = UIColor.black
        userNameLbl.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(userNameLbl)
        userNameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(8)
        }
        
        chatLbl.textColor = UIColor.lightGray
        chatLbl.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(chatLbl)
        chatLbl.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLbl.snp.bottom).offset(12)
            make.left.equalTo(userNameLbl)
        }
        
        timeLbl.textAlignment = .right
        timeLbl.font = UIFont.systemFont(ofSize: 12)
        timeLbl.textColor = UIColor.lightGray
        self.addSubview(timeLbl)
        timeLbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView)
            make.right.equalTo(-12)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        userNameLbl.text = nil
        chatLbl.text = nil
        timeLbl.text = nil
        // TOLEARN
        disposeBag = DisposeBag()
    }
    

}
