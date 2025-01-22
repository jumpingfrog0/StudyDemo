//
//  ViewController.swift
//  SwiftDemo
//
//  Created by lizhi on 2024/11/22.
//

import UIKit
import SnapKit
import Toast_Swift

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
    
    let swipeIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.0 // 初始时隐藏
        return imageView
    }()
    
    private var swipeGestureRecognizer: ChatSwipeToReplyRecognizer?
    
    // 用于记录原始位置以恢复
    private var swipeContentViewOriginalPosition: CGPoint = .zero
    private var swipeIconOriginalPosition: CGPoint = .zero
    // 限制最大滚动距离
    private var swipeIconMaxTranslation: CGFloat = 30.0
    private var swipeMaxTranslation: CGFloat {
        return swipeIconMaxTranslation * 2
    }
    
    /// 右滑引用的内容容器
    var swipeContentView: UIView? {
        return bubbleView
    }

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
        contentView.addSubview(swipeIconImageView)
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

        if let swipeContentView = self.swipeContentView {
            swipeIconImageView.snp.makeConstraints { make in
//                make.leading.equalTo(swipeContentView.snp.leading).offset(0)
                make.leading.equalTo(contentView.snp.leading).offset(0)
                make.bottom.equalTo(bubbleView)
                make.width.height.equalTo(15)
            }
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
        let translation: CGPoint = recognizer.translation(in: contentView)
        switch recognizer.state {
            case .began:
                // 初始化开始的状态
                self.beginSwipeGesture(recognizer)
                
            case .changed:
                // 根据滑动更新UI
                self.updateSwipeTranslation(translation)
                
            case .ended, .cancelled:
                // 恢复滑动前的状态
                self.endSwipeGesture(recognizer, translation: translation)
                
            default:
                break
        }
    }

    private func beginSwipeGesture(_ recognizer: ChatSwipeToReplyRecognizer) {
        guard let swipeContentView = self.swipeContentView else { return }
        
        // 记录初始位置
        swipeContentViewOriginalPosition = swipeContentView.center
        swipeIconOriginalPosition = swipeIconImageView.center
        
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
        guard let swipeContentView = self.swipeContentView else { return }
        
        // 更新UI
        if translation.x > 0 { // 仅在右滑时生效
            let moveX = min(translation.x, swipeMaxTranslation)
            let iconMoveX = min(translation.x, swipeIconMaxTranslation)

            swipeContentView.center = CGPoint(x: swipeContentViewOriginalPosition.x + moveX, y: swipeContentViewOriginalPosition.y)
            swipeIconImageView.center = CGPoint(x: swipeIconOriginalPosition.x + iconMoveX, y: swipeIconOriginalPosition.y)

            // 根据移动距离动态修改透明度，最大透明度为1.0
            swipeIconImageView.alpha = min(iconMoveX / swipeIconMaxTranslation, 1.0)
        }
    }

    private func endSwipeGesture(_ recognizer: ChatSwipeToReplyRecognizer, translation: CGPoint) {
        // 恢复原状
        guard let swipeContentView = self.swipeContentView else { return }

        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else { return }
            swipeContentView.center = self.swipeContentViewOriginalPosition
            swipeIconImageView.center = self.swipeIconOriginalPosition
            swipeIconImageView.alpha = 0.0
        }
        
        if .ended == recognizer.state, translation.x >= swipeMaxTranslation {
            // do something
            self.window?.makeToast("This is a piece of toast", duration: 0.5)
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
