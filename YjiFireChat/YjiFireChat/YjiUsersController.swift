//
//  YjiUsersController.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit

class YjiUsersController: UIViewController {
    
    let tableView = UITableView()
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    let model = YjiUsersModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = UserDefaults.standard.object(forKey: UserInfoKey.userName) as? String
        self.view.backgroundColor = UIColor.white
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        indicator.tintColor = UIColor.purple
        self.view.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        tableView.register(YjiUsersCell.classForCoder(), forCellReuseIdentifier: "UsersCell")
        setUpTableView()
        getData()
        model.setListener()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func getData() {
        indicator.startAnimating()
        model.getUsers {[weak self] msg in
            self?.indicator.stopAnimating()
            if let errorMsg = msg {
                print("error = \(errorMsg)")
            }
            
            self?.tableView.reloadData()
        }
    }
}

extension YjiUsersController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let info = model.users[indexPath.row]
        YjiSQliteManager.sharedInstance.insertChat(info: info)
        info.isReaded.value = true
        
        guard let selfUserId = YjiComonFunc.getUserId() else {return}
        let conversationId = YjiComonFunc.getConversationId(userId1: selfUserId, userId2: info.userId)
        let chatController = YjiChatController(conversationId: conversationId, targetUserName: info.userName)
        self.navigationController?.pushViewController(chatController, animated: true)
    }
}

extension YjiUsersController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath)
        if let usersCell = cell as? YjiUsersCell {
            let info = model.users[indexPath.row]
            usersCell.userNameLbl.text = info.userName
            usersCell.iconImageView.image = UIImage(named: "jiyun")
            info.lastMessage.asObservable().bindTo(usersCell.chatLbl.rx.text).addDisposableTo(usersCell.disposeBag)
            info.lastMessageTime.asObservable().bindTo(usersCell.timeLbl.rx.text).addDisposableTo(usersCell.disposeBag)
            info.isReaded.asObservable().bindTo(usersCell.unreadView.rx.isHidden).addDisposableTo(usersCell.disposeBag)
        }
        return cell
    }
}
