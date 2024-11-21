//
//  VerificaitonCodeInputView.swift
//  SwiftDemo
//
//  Created by huangdonghong on 2024/10/25.
//  Copyright © 2024 lizhi. All rights reserved.
//

import UIKit
import SnapKit
import Foundation
import SwifterSwift

//验证码输入框
class VerificaitonCodeInputView: UIView, UITextFieldDelegate {
    
    public typealias VerificaitonCodeInpuBlock = (_ code: String, _ isComplete: Bool) -> Void

    var resultBlock: VerificaitonCodeInpuBlock?
    private var itemCount = 0 //验证码长度
    private var labels = [UILabel]()
    var onAutoPaste : ((Bool) -> Void)?
    private var currentIndex: Int = 0
    
    convenience init(itemCount: Int) {
        self.init()
        self.itemCount = itemCount
        self.currentIndex = 0
        setUpUI()
        
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    var codeText: String{
        get{
            return textField.text ?? ""
        }
    }
    
    var textField: UITextField = {
        let textField = UITextField.init()
        textField.textContentType = .oneTimeCode
        textField.keyboardType = .asciiCapableNumberPad
        textField.textColor = .clear
        textField.tintColor = .clear
        return textField
    }()
    
    private func setUpUI(){
        
        let stackView = UIStackView.init()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        addSubview(textField)
        addSubview(stackView)

        for index in 0 ..< itemCount {
            let label = UILabel()
            label.textColor = .white
            label.layer.cornerRadius = 8
            label.textAlignment = .center
            label.tag = 100 + index
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAction(_:))))
            labels.append(label)
            stackView.addArrangedSubview(label)
            updateLabelUI(label, isHighlight: index == 0)
        }
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.textField.delegate = self
    }
    
    func updateLabelUI(_ label: UILabel, isHighlight: Bool) {
        label.backgroundColor = isHighlight ? UIColor(white: 1, alpha: 0.1) : UIColor(white: 1, alpha: 0.06)
        label.layer.borderWidth = isHighlight ? 1 : 0
        label.layer.borderColor = isHighlight ? UIColor.green.cgColor : nil
    }
    
    func moveCursor(to position: Int, in textField: UITextField) {
        guard let startPosition = textField.position(from: textField.beginningOfDocument, offset: position) else { return }
        textField.selectedTextRange = textField.textRange(from: startPosition, to: startPosition)
    }
    
    func beginEdit(){
        textField.becomeFirstResponder()
    }
    
    @objc func onTapAction(_ recognizer: UITapGestureRecognizer) {
        guard let label = recognizer.view as? UILabel else { return }
        let index = label.tag - 100
        self.currentIndex = index
        self.moveCursor(to: self.currentIndex + 1, in: self.textField)
        for (index, label) in labels.enumerated() {
            updateLabelUI(label, isHighlight: index == self.currentIndex)
        }
        print("--test-- selectedTextRange \(self.textField.selectedTextRange)")
    }
    
    @objc func textFieldEditingChanged(){
        if false == textField.text?.isDigits {
            textField.text = ""
        }
        
        if textField.text?.length ?? 0 > self.itemCount {
            textField.text = textField.text?.substring(toLength: self.itemCount)
        }
        
        for (index, label) in labels.enumerated() {
            updateLabelUI(label, isHighlight: index == textField.text?.length)
            if var text = textField.text, index < text.length {
                label.text = text.slice(from: index, length: 1)
            }else{
                label.text = ""
            }
        }
        
        if var text = textField.text {
            text = text.substring(toLength: itemCount)
            if (resultBlock != nil) {
                self.resultBlock?(text, text.length == itemCount)
            }
            
            if text.length >= self.itemCount {
                textField.resignFirstResponder()
            }
        }
    }


    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        self.onAutoPaste?(string.length == itemCount)
        
        print("--test-- \(string) \(range)")
        if string.isEmpty { // 删除
            
        } else {
            
        }
        return true
    }
}
