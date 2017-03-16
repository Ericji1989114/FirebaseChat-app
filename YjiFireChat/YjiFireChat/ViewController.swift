//
//  ViewController.swift
//  YjiFireChat
//
//  Created by 季 雲 on 2017/03/16.
//  Copyright © 2017年 Ericji. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let startBtn = UIButton()
        startBtn.setTitle("Start Chat", for: .normal)
        startBtn.setTitleColor(UIColor.white, for: .normal)
        startBtn.backgroundColor = UIColor.green
        startBtn.layer.cornerRadius = 10
        startBtn.layer.masksToBounds = true
        startBtn.addTarget(self, action: #selector(ViewController.onTapStartAction(btn:)), for: .touchUpInside)
        self.view.addSubview(startBtn)
        startBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalTo(self.view)
        }
    }
    
    @objc private func onTapStartAction(btn: UIButton) {
        if let _ = UserDefaults.standard.object(forKey: UserInfoKey.userId) as? String {
            // to user view controller
            let vc = YjiUsersController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // to name view controller
            let vc = YjiNameController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

