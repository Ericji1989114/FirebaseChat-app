//
//  YjiNameController.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Firebase

class YjiNameController: UIViewController {
    
    let nameTf = UITextField()
    let confirmBtn = UIButton()
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // layout setting
        self.title = "Let's start"
        self.view.backgroundColor = UIColor.init(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(180)
        }
        
        nameTf.font = UIFont.systemFont(ofSize: 20)
        nameTf.textColor = UIColor.blue
        nameTf.textAlignment = .left
        nameTf.placeholder = "Please set your name!"
        nameTf.borderStyle = .roundedRect
        contentView.addSubview(nameTf)
        nameTf.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(50)
            make.height.equalTo(40)
        }
        
        confirmBtn.setTitle("OK", for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.backgroundColor = UIColor.green
        confirmBtn.layer.cornerRadius = 10
        confirmBtn.layer.masksToBounds = true
        confirmBtn.isEnabled = false
        confirmBtn.addTarget(self, action: #selector(YjiNameController.onTapOkAction(btn:)), for: .touchUpInside)
        contentView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(nameTf)
            make.bottom.equalTo(-25)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(YjiNameController.onTapView(_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        // observe user handle
        nameTf.rx.text.asObservable().map { (text) -> Bool in
            return text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != ""
        }.bindTo(confirmBtn.rx.isEnabled).addDisposableTo(disposeBag)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func onTapOkAction(btn: UIButton) {
        setUpFBDB()
        let vc = YjiUsersController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func onTapView(_ sender: UITapGestureRecognizer?) {
        self.view.endEditing(true)
    }

    private func setUpFBDB() {
        guard let userName = nameTf.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {return}
        
        // local DB
        let userId = NSUUID().uuidString
        let userDefault = UserDefaults.standard
        userDefault.set(userId, forKey: UserInfoKey.userId)
        userDefault.set(userName, forKey: UserInfoKey.userName)
        userDefault.synchronize()
        
        // Server DB
        var userDic = [String : Any]()
        userDic[UserInfoKey.userName] = userName
        userDic[UserInfoKey.imageUrl] = ""
        let key = userId
        var serverDic = [String : Any]()
        serverDic[key] = userDic
        let ref = FIRDatabase.database().reference()
        ref.child("Users").updateChildValues(serverDic)
        
    }

}
