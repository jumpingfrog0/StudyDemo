//
//  ViewController.swift
//  SwiftDemo
//
//  Created by lizhi on 2024/8/5.
//

import UIKit

class ViewController2: UIViewController {
    
    private(set) var codeInputView: VerificaitonCodeInputView = {
        let view = VerificaitonCodeInputView.init(itemCount: 6)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func inputCode() {
        self.view.backgroundColor = .black
        print("SwiftDemo")
        
        self.view.addSubview(codeInputView)
        codeInputView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
            make.height.equalTo(50)
        }
        
        let otpView = OTPInputView(frame: CGRect(x: 20, y: 200, width: 280, height: 50))
        view.addSubview(otpView)
//        otpView.beginEdit()
        
//        beginEdit()
    }

    func beginEdit() {
        codeInputView.beginEdit()
    }
    
    func endEditing() {
        codeInputView.resignFirstResponder()
    }
}

