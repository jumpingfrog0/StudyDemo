//
//  ViewController3.swift
//  SwiftDemo
//
//  Created by lizhi on 2024/8/5.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let swipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_official") // 确保替换为您的图片名称
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0 // 初始化时隐藏
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupGesture()
        contentView.addSubview(swipeImageView)
        contentView.backgroundColor = .yellow
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGesture()
        contentView.addSubview(swipeImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            swipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            swipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            swipeImageView.widthAnchor.constraint(equalToConstant: 30),
            swipeImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func canReply() -> Bool {
        return true
    }

    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        contentView.addGestureRecognizer(panGesture)
        
//        let replyRecognizer = ChatSwipeToReplyRecognizer(target: self, action: #selector(self.swipeToReplyGesture(_:)))
//        replyRecognizer.allowBothDirections = false
//        replyRecognizer.shouldBegin = { [weak self] in
//            guard let `self` = self else { return false }
//            return self.canReply()
//        }
////        self.replyRecognizer = replyRecognizer
//        self.contentView.addGestureRecognizer(replyRecognizer)
    }
    
//    @objc private func swipeToReplyGesture(_ recognizer: ChatSwipeToReplyRecognizer) {
//        var offset: CGFloat = 0.0
//        var leftOffset: CGFloat = 0.0
//        var swipeOffset: CGFloat = 45.0
//        if let item = self.item, item.content.effectivelyIncoming(item.context.account.peerId, associatedData: item.associatedData) {
//            offset = -24.0
//            leftOffset = -10.0
//        } else {
//            offset = 10.0
//            leftOffset = -10.0
//            swipeOffset = 60.0
//        }
//        
//        switch recognizer.state {
//            case .began:
//                self.playedSwipeToReplyHaptic = false
//                self.currentSwipeToReplyTranslation = 0.0
//                if self.swipeToReplyFeedback == nil {
//                    self.swipeToReplyFeedback = HapticFeedback()
//                    self.swipeToReplyFeedback?.prepareImpact()
//                }
//                self.item?.controllerInteraction.cancelInteractiveKeyboardGestures()
//            case .changed:
//                var translation = recognizer.translation(in: self.view)
//                func rubberBandingOffset(offset: CGFloat, bandingStart: CGFloat) -> CGFloat {
//                    let bandedOffset = offset - bandingStart
//                    if offset < bandingStart {
//                        return offset
//                    }
//                    let range: CGFloat = 100.0
//                    let coefficient: CGFloat = 0.4
//                    return bandingStart + (1.0 - (1.0 / ((bandedOffset * coefficient / range) + 1.0))) * range
//                }
//            
//                if translation.x < 0.0 {
//                    translation.x = max(-180.0, min(0.0, -rubberBandingOffset(offset: abs(translation.x), bandingStart: swipeOffset)))
//                } else {
//                    if recognizer.allowBothDirections {
//                        translation.x = -max(-180.0, min(0.0, -rubberBandingOffset(offset: abs(translation.x), bandingStart: swipeOffset)))
//                    } else {
//                        translation.x = 0.0
//                    }
//                }
//            
//                if let item = self.item, self.swipeToReplyNode == nil {
//                    let swipeToReplyNode = ChatMessageSwipeToReplyNode(fillColor: selectDateFillStaticColor(theme: item.presentationData.theme.theme, wallpaper: item.presentationData.theme.wallpaper), enableBlur: item.controllerInteraction.enableFullTranslucency && dateFillNeedsBlur(theme: item.presentationData.theme.theme, wallpaper: item.presentationData.theme.wallpaper), foregroundColor: bubbleVariableColor(variableColor: item.presentationData.theme.theme.chat.message.shareButtonForegroundColor, wallpaper: item.presentationData.theme.wallpaper), backgroundNode: item.controllerInteraction.presentationContext.backgroundNode, action: ChatMessageSwipeToReplyNode.Action(self.currentSwipeAction))
//                    self.swipeToReplyNode = swipeToReplyNode
//                    self.insertSubnode(swipeToReplyNode, at: 0)
//                }
//            
//                self.currentSwipeToReplyTranslation = translation.x
//                var bounds = self.bounds
//                bounds.origin.x = -translation.x
//                self.bounds = bounds
//                var shadowBounds = self.shadowNode.bounds
//                shadowBounds.origin.x = -translation.x
//                self.shadowNode.bounds = shadowBounds
//
//                self.updateAttachedAvatarNodeOffset(offset: translation.x, transition: .immediate)
//            
//                if let swipeToReplyNode = self.swipeToReplyNode {
//                    if translation.x < 0.0 {
//                        swipeToReplyNode.bounds = CGRect(origin: .zero, size: CGSize(width: 33.0, height: 33.0))
//                        swipeToReplyNode.position = CGPoint(x: bounds.size.width + offset + 33.0 * 0.5, y: self.contentSize.height / 2.0)
//                    } else {
//                        swipeToReplyNode.bounds = CGRect(origin: .zero, size: CGSize(width: 33.0, height: 33.0))
//                        swipeToReplyNode.position = CGPoint(x: leftOffset - 33.0 * 0.5, y: self.contentSize.height / 2.0)
//                    }
//
//                    if let (rect, containerSize) = self.absoluteRect {
//                        let mappedRect = CGRect(origin: CGPoint(x: rect.minX + swipeToReplyNode.frame.minX, y: rect.minY + swipeToReplyNode.frame.minY), size: swipeToReplyNode.frame.size)
//                        swipeToReplyNode.updateAbsoluteRect(mappedRect, within: containerSize)
//                    }
//                    
//                    let progress = abs(translation.x) / swipeOffset
//                    swipeToReplyNode.updateProgress(progress)
//                    
//                    if progress > 1.0 - .ulpOfOne && !self.playedSwipeToReplyHaptic {
//                        self.playedSwipeToReplyHaptic = true
//                        self.swipeToReplyFeedback?.impact(.heavy)
//                    }
//                }
//            case .cancelled, .ended:
//                self.swipeToReplyFeedback = nil
//                
//                let translation = recognizer.translation(in: self.view)
//                let gestureRecognized: Bool
//                if recognizer.allowBothDirections {
//                    gestureRecognized = abs(translation.x) > swipeOffset
//                } else {
//                    gestureRecognized = translation.x < -swipeOffset
//                }
//                if case .ended = recognizer.state, gestureRecognized {
//                    if let item = self.item {
//                        if let currentSwipeAction = currentSwipeAction {
//                            switch currentSwipeAction {
//                            case .none:
//                                break
//                            case .reply:
//                                item.controllerInteraction.setupReply(item.message.id)
//                            }
//                        }
//                    }
//                }
//                var bounds = self.bounds
//                let previousBounds = bounds
//                bounds.origin.x = 0.0
//                self.bounds = bounds
//                var shadowBounds = self.shadowNode.bounds
//                let previousShadowBounds = shadowBounds
//                shadowBounds.origin.x = 0.0
//                self.shadowNode.bounds = shadowBounds
//                self.layer.animateBounds(from: previousBounds, to: bounds, duration: 0.3, timingFunction: kCAMediaTimingFunctionSpring)
//
//                self.updateAttachedAvatarNodeOffset(offset: 0.0, transition: .animated(duration: 0.3, curve: .spring))
//
//                self.shadowNode.layer.animateBounds(from: previousShadowBounds, to: shadowBounds, duration: 0.3, timingFunction: kCAMediaTimingFunctionSpring)
//                if let swipeToReplyNode = self.swipeToReplyNode {
//                    self.swipeToReplyNode = nil
//                    swipeToReplyNode.layer.animateAlpha(from: 1.0, to: 0.0, duration: 0.3, removeOnCompletion: false, completion: { [weak swipeToReplyNode] _ in
//                        swipeToReplyNode?.removeFromSupernode()
//                    })
//                    swipeToReplyNode.layer.animateScale(from: 1.0, to: 0.2, duration: 0.3, timingFunction: kCAMediaTimingFunctionSpring, removeOnCompletion: false)
//                }
//            default:
//                break
//        }
//    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        print("\(gesture.state) translation.x - \(translation.x)")

        // 处理左滑
        if translation.x < 0 { // 仅处理向左滑动
            contentView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            swipeImageView.alpha = min(1.0, abs(translation.x) / 100) // 逐步显示图片
        }

        if gesture.state == .ended || gesture.state == .cancelled {
            // 滑动结束，回弹
            UIView.animate(withDuration: 0.3, animations: {
                self.contentView.transform = .identity
                self.swipeImageView.alpha = 0
            })
        }
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .yellow
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
    }

    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

