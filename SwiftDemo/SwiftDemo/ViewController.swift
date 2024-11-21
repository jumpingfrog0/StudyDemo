//
//  ViewController.swift
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

    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        contentView.addGestureRecognizer(panGesture)
    }

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

