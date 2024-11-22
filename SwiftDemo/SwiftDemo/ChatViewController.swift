//
//  ViewController.swift
//  SwiftDemo
//
//  Created by lizhi on 2024/11/22.
//

import UIKit
import SnapKit

struct Message {
    let text: String
    let isIncoming: Bool
}

class ChatBubbleCell: UITableViewCell {
    
    var model: Int = 0
    var isIncoming: Bool = false // 用于区分左右消息

    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        view.layer.cornerRadius = 15
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.0 // 初始时隐藏
        return imageView
    }()
    
    private var swipeGestureRecognizer: ChatSwipeToReplyRecognizer?
    
    // 用于记录原始位置以恢复
    private var originalBubbleCenter: CGPoint = .zero
    private var iconOriginalPosition: CGPoint = .zero
    private var maxTranslation: CGFloat = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none // 取消选中样式
        setup()
    }
    
    private func setup() {
        selectionStyle = .none // 取消选中样式
        setupLayout()
        setupReplyGesture()
    }
    
    private func setupLayout() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)

        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            if isIncoming {
                make.leading.equalTo(contentView).offset(20)
                make.trailing.lessThanOrEqualTo(contentView).offset(-50)
            } else {
                make.leading.greaterThanOrEqualTo(contentView).offset(50)
                make.trailing.equalTo(contentView).offset(-20)
            }
        }

        messageLabel.snp.makeConstraints { make in
            make.edges.equalTo(bubbleView).inset(10)
        }

        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(bubbleView.snp.leading).offset(0)
            make.bottom.equalTo(bubbleView)
            make.width.height.equalTo(15)
        }
        
    }
    
    func configure(with message: Message) {
        isIncoming = message.isIncoming
        
        bubbleView.snp.remakeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            if isIncoming {
                make.leading.equalTo(contentView).offset(20)
                make.trailing.lessThanOrEqualTo(contentView).offset(-50)
            } else {
                make.leading.greaterThanOrEqualTo(contentView).offset(50)
                make.trailing.equalTo(contentView).offset(-20)
            }
        }
        
        messageLabel.text = message.text
        if isIncoming {
            bubbleView.backgroundColor = .systemBlue
        } else {
            bubbleView.backgroundColor = .systemGreen
        }
    }
    
    func canReply() -> Bool {
        // 判断是否可以引用
        return model % 2 == 0
    }
    
    private func setupReplyGesture() {
        let gesture = ChatSwipeToReplyRecognizer(target: self, action: #selector(handleSwipe(_:)))
        gesture.shouldBegin = { [weak self] in
            guard let `self` = self else { return false }
            return self.canReply()
        }
//        gesture.allowBothDirections = false
        contentView.addGestureRecognizer(gesture)
        self.swipeGestureRecognizer = gesture
    }
    
    @objc private func handleSwipe(_ recognizer: ChatSwipeToReplyRecognizer) {
        switch recognizer.state {
            case .began:
                // 初始化开始的状态
                self.beginSwipeGesture(recognizer)
                
            case .changed:
                // 根据滑动更新UI
                self.updateSwipeTranslation(recognizer.translation(in: contentView))
                
            case .ended, .cancelled:
                // 恢复滑动前的状态
                self.endSwipeGesture()
                
            default:
                break
        }
    }

    private func beginSwipeGesture(_ recognizer: ChatSwipeToReplyRecognizer) {
        // 记录初始位置
        originalBubbleCenter = bubbleView.center
        iconOriginalPosition = iconImageView.center
        if isIncoming {
            maxTranslation = bubbleView.frame.minX // 限制最大滚动距离
        } else {
            maxTranslation = contentView.frame.width - bubbleView.frame.maxX // 限制最大滚动距离
        }
        
        guard let cell = recognizer.view as? UITableViewCell,
              let tableView = self.findTableView() else {
            return
        }

        if let indexPath = tableView.indexPath(for: cell) {
            print("Current indexPath: \(indexPath)")
            // 继续处理滑动手势相关的逻辑
        }
    }

    private func updateSwipeTranslation(_ translation: CGPoint) {
        // 更新UI逻辑
        if translation.x > 0 { // 仅在右滑时生效
            let moveX = min(translation.x, maxTranslation)

            print("moveX \(moveX) maxTranslation \(maxTranslation)")

            bubbleView.center = CGPoint(x: originalBubbleCenter.x + moveX, y: originalBubbleCenter.y)
            iconImageView.center = CGPoint(x: iconOriginalPosition.x - moveX * 0.3, y: iconOriginalPosition.y)

            // 根据移动距离动态修改透明度，最大透明度为1.0
            iconImageView.alpha = min(moveX / maxTranslation, 1.0)
        }
        
//        var moveX = isIncoming ? -translation.x : translation.x
//        
//        print("moveX \(moveX) maxTranslation \(maxTranslation)")
//        
//        if moveX > 0 { // 仅当对称方向滑动时生效
//            moveX = min(moveX, maxTranslation)
//            
//            bubbleView.center = CGPoint(x: originalBubbleCenter.x + (isIncoming ? -moveX : moveX), y: originalBubbleCenter.y)
//            iconImageView.center = CGPoint(x: iconOriginalPosition.x + (isIncoming ? moveX * 0.3 : -moveX * 0.3), y: iconOriginalPosition.y)
//            
//            iconImageView.alpha = min(moveX / maxTranslation, 1.0)
//        }
    }

    private func endSwipeGesture() {
        // 重置逻辑
        // 恢复原状
        UIView.animate(withDuration: 0.3) {
            self.bubbleView.center = self.originalBubbleCenter
            self.iconImageView.center = self.iconOriginalPosition
            self.iconImageView.alpha = 0.0
        }
    }
}

extension UIView {
    func findTableView() -> UITableView? {
        if let tableView = self as? UITableView {
            return tableView
        }
        return superview?.findTableView()
    }
}

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var messages: [Message] = [
        Message(text: "Test", isIncoming: false),
        Message(text: "Test2", isIncoming: true),
        Message(text: "Test3", isIncoming: false),
        Message(text: "Test4", isIncoming: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    private func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatBubbleCell.self, forCellReuseIdentifier: "ChatBubbleCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBubbleCell", for: indexPath) as! ChatBubbleCell
        let message = messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
}
