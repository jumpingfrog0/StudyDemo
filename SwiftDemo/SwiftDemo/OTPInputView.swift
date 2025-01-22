//
//  OTPInputView.swift
//  SwiftDemo
//
//  Created by huangdonghong on 2024/10/25.
//  Copyright © 2024 lizhi. All rights reserved.
//

import UIKit

class OTPInputView: UIView, UITextFieldDelegate {
    
    private var labels: [UILabel] = []
    private let numberOfFields: Int = 6
    private let hiddenTextField = UITextField()
    
    private var _selectedIndex: Int = 0
    private var selectedIndex: Int {
        get {
            return _selectedIndex
        }
        set {
            _selectedIndex = max(0, min(newValue, numberOfFields - 1))
        }
    }
    
    var contentText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Setup hidden UITextField
        hiddenTextField.keyboardType = .numberPad
        hiddenTextField.delegate = self
        hiddenTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        hiddenTextField.isHidden = true
        addSubview(hiddenTextField)
        
        // Setup UILabels
        for i in 0..<numberOfFields {
            let label = UILabel()
            label.textAlignment = .center
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.gray.cgColor
            label.layer.cornerRadius = 5.0
            label.clipsToBounds = true
            label.font = UIFont.systemFont(ofSize: 24)
            label.textColor = .white
            label.backgroundColor = .black
            label.isUserInteractionEnabled = true
            label.tag = i
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.addGestureRecognizer(tapGesture)
            
            addSubview(label)
            labels.append(label)
        }
        
        // Start editing
        hiddenTextField.becomeFirstResponder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let fieldWidth: CGFloat = (bounds.width - CGFloat(numberOfFields - 1) * 10) / CGFloat(numberOfFields)
        for (index, label) in labels.enumerated() {
            label.frame = CGRect(x: CGFloat(index) * (fieldWidth + 10), y: 0, width: fieldWidth, height: bounds.height)
        }
        hiddenTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0) // Keep it hidden
    }
    
    @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
        if let label = gesture.view as? UILabel {
            selectedIndex = label.tag
            updateLabelBorders()
            hiddenTextField.becomeFirstResponder()
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textField.text = self.contentText
        print("result - " + self.contentText + "-" + (self.hiddenTextField.text ?? ""))
    }
    
    private func updateLabelBorders() {
        var content = ""
        for (index, label) in labels.enumerated() {
            label.layer.borderColor = (index == selectedIndex) ? UIColor.red.cgColor : UIColor.gray.cgColor
            content = content + (label.text ?? "")
        }
        self.contentText = content
        print(self.contentText)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = self.contentText
        let newLength = currentText.count + string.count - range.length
        
        if string.isEmpty { // Handle backspace
            if let s = labels[selectedIndex].text, s.isEmpty {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
                
            }
            labels[selectedIndex].text = ""
            
            updateLabelBorders()
            return true
        }
        
        if newLength <= numberOfFields {
            if selectedIndex < numberOfFields {
                labels[selectedIndex].text = string
                selectedIndex += 1
            }
            updateLabelBorders()
            return true
        }
        
        return true
    }
}
