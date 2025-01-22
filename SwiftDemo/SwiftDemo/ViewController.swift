//
//  ViewController.swift
//  SwiftDemo
//
//  Created by lizhi on 2024/8/5.
//

import UIKit
import SnapKit

//class BottomBar: UIView {
//    
//    private var stackWidthConstraint: Constraint?
//    
//    private let upvoteButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "star"), for: .normal)
//        button.setTitle("50", for: .normal)
//        button.backgroundColor = .white
//        button.layer.cornerRadius = 15
//        button.tintColor = .black
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        return button
//    }()
//    
//    private let downvoteButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "star"), for: .normal)
//        button.setTitle("1", for: .normal)
//        button.backgroundColor = .white
//        button.layer.cornerRadius = 15
//        button.tintColor = .black
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        return button
//    }()
//    
//    private let unreadButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("50 unread", for: .normal)
//        button.backgroundColor = .white
//        button.layer.cornerRadius = 15
//        button.tintColor = .black
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        return button
//    }()
//    
//    private let stackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.distribution = .equalSpacing
//        stack.alignment = .center
//        stack.spacing = 10
//        return stack
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        addSubview(stackView)
//        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(10)
//            stackWidthConstraint = make.width.equalTo(100).constraint
//        }
//        updateButtons(style: .upvoteAndDownvote)
//    }
//    
//    enum BottomBarStyle {
//        case unread
//        case upvote
//        case upvoteAndDownvote
//    }
//    
//    func updateButtons(style: BottomBarStyle) {
//        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
//        
//        switch style {
//        case .unread:
//            stackView.addArrangedSubview(unreadButton)
//            updateWidth(for: 1)
//        case .upvote:
//            stackView.addArrangedSubview(upvoteButton)
//            updateWidth(for: 1)
//        case .upvoteAndDownvote:
//            stackView.addArrangedSubview(upvoteButton)
//            stackView.addArrangedSubview(downvoteButton)
//            updateWidth(for: 2)
//        }
//    }
//    
//    private func updateWidth(for buttonCount: Int) {
//        let widthPerButton: CGFloat = 80 // 每个按钮的宽度
//        let totalWidth = CGFloat(buttonCount) * widthPerButton + CGFloat(buttonCount - 1) * stackView.spacing
//        stackWidthConstraint?.update(offset: totalWidth)
//        layoutIfNeeded()
//    }
//}
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        setupBottomBar()
//    }
//
//    lazy var bottomBar: BottomBar = {
//        let view = BottomBar()
//        view.backgroundColor = .yellow
//        return view
//    }()
//
//    func setupBottomBar() {
//        view.addSubview(bottomBar)
//        bottomBar.snp.makeConstraints { make in
////            make.leading.equalToSuperview().offset(20)
////            make.trailing.equalToSuperview().offset(-20)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(50)
//            make.centerY.equalToSuperview()
//        }
//        
//        // 更新样式为其中一种
//        bottomBar.updateButtons(style: .upvoteAndDownvote)
//    }
//}


//class BottomBar: UIView {
//    
//    private let unreadButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .green
//        button.setTitle("0 unread", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let countButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .blue
//        button.setTitle("0", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        addSubview(unreadButton)
//        addSubview(countButton)
//        
//        // 使用 SnapKit 设置按钮的约束
//        unreadButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(10)
//            make.centerY.equalToSuperview()
//        }
//        
//        countButton.snp.makeConstraints { make in
//            make.leading.equalTo(unreadButton.snp.trailing).offset(10)
//            make.trailing.equalToSuperview().offset(-10)
//            make.centerY.equalToSuperview()
//        }
//    }
//    
//    // 更新未读数和数量
//    func updateUnreadCount(_ count: Int) {
//        unreadButton.setTitle("\(count) unread", for: .normal)
//    }
//    
//    func updateCount(_ count: Int) {
//        countButton.setTitle("\(count)", for: .normal)
//    }
//    
//    // 控制按钮的显示
//    func showCountButton(_ show: Bool) {
//        countButton.isHidden = !show
//        updateLayout()
//    }
//    
//    func showUnreadButton(_ show: Bool) {
//        unreadButton.isHidden = !show
//        updateLayout()
//    }
//    
//    private func updateLayout() {
//        // 更新布局以适应可见按钮
//        if unreadButton.isHidden && countButton.isHidden {
//            self.snp.makeConstraints { make in
//                make.height.equalTo(0) // 如果两个按钮都隐藏，设置高度为0
//            }
//        } else {
//            self.snp.makeConstraints { make in
//                make.height.equalTo(50) // 设置高度
//            }
//        }
//    }
//}
//
//class ViewController: UIViewController {
//    
//    private let bottomBar = BottomBar()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        
//        // 添加 BottomBar 到视图
//        view.addSubview(bottomBar)
//        bottomBar.backgroundColor = .yellow
//        
//        // 设置 BottomBar 的约束
//        bottomBar.translatesAutoresizingMaskIntoConstraints = false
//        bottomBar.snp.makeConstraints { make in
//            make.centerX.equalToSuperview() // 水平居中
//            make.centerY.equalToSuperview() // 水平居中
//            make.height.equalTo(50) // 设置高度
//        }
//        
//        // 更新按钮的内容
//        bottomBar.updateUnreadCount(10)
//        bottomBar.updateCount(1)
//        
//        // 控制显示
//        bottomBar.showCountButton(false) // 显示右边按钮
//        bottomBar.showUnreadButton(true) // 显示左边按钮
//    }
//}

//import UIKit
//import SnapKit

class BottomBar: UIView {
    
    let unreadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.setTitle("0 unread", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    let countButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(unreadButton)
        stackView.addArrangedSubview(countButton)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    // 更新未读数和数量
    func updateUnreadCount(_ count: Int) {
        unreadButton.setTitle("\(count) unread", for: .normal)
    }
    
    func updateCount(_ count: Int) {
        countButton.setTitle("\(count)", for: .normal)
    }
    
    // 控制按钮的显示
    func showCountButton(_ show: Bool) {
        countButton.isHidden = !show
    }
    
    func showUnreadButton(_ show: Bool) {
        unreadButton.isHidden = !show
    }
}

class ViewController: UIViewController {
    
    private let bottomBar = BottomBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 添加 BottomBar 到视图
        view.addSubview(bottomBar)
        bottomBar.backgroundColor = .yellow
        
        // 设置 BottomBar 的约束
        bottomBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 水平居中
            make.centerY.equalToSuperview()
        }
        
        // 更新按钮的内容
        bottomBar.updateUnreadCount(10)
        bottomBar.updateCount(1)
        
        // 控制按钮显示
        bottomBar.showCountButton(false)
        bottomBar.showUnreadButton(true)
        
        bottomBar.unreadButton.setTitle("\(8) yyyyyyyyyyyyy", for: .normal)
    }
}
