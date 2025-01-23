//
//  ViewController.swift
//  FlutterDemoMain
//
//  Created by lizhi on 2025/1/22.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .system)
        btn.setTitle("go flutter", for: .normal)
        btn.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
//        btn.backgroundColor = .red
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        view.addSubview(btn)
    }

    @objc func onClickButton() {
        let flutterVc = FlutterViewController()
        present(flutterVc, animated: true)
    }

}

