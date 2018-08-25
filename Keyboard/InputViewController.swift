//
//  InputViewController.swift
//  Keyboard
//
//  Created by ttionn on 2018/8/25.
//  Copyright © 2018 Tong Tian. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
    }
    
    var inputContainerHeightConstraint: NSLayoutConstraint!
    var inputContainerBottomConstraint: NSLayoutConstraint!
    
    let inputContainerView: UIView = {
        let view = UIView()
        return view
    }()

    var inputTextHeightConstraint: NSLayoutConstraint!
    
    lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.isScrollEnabled = false
        textView.delegate = self
        return textView
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Post", for: .normal)
        button.addTarget(self, action: #selector(handlePost), for: .touchUpInside)
        return button
    }()
    
    func setupViews() {
        view.addSubview(inputContainerView)
        view.addConstraints(format: "H:|[v0]|", views: inputContainerView)
        
        inputContainerHeightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 56)
        inputContainerHeightConstraint.isActive = true
        inputContainerBottomConstraint = inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        inputContainerBottomConstraint.isActive = true
        
        let borderView = UIView()
        borderView.backgroundColor = UIColor.lightGray
        
        inputContainerView.addSubview(borderView)
        inputContainerView.addConstraints(format: "H:|[v0]|", views: borderView)
        inputContainerView.addConstraints(format: "V:|[v0(1)]", views: borderView)
        
        inputContainerView.addSubview(inputTextView)
        inputContainerView.addSubview(postButton)
        inputContainerView.addConstraints(format: "H:|-10-[v0]-10-[v1(40)]-15-|", views: inputTextView, postButton)
        inputContainerView.addConstraints(format: "V:[v0]-10-|", views: inputTextView)
        inputContainerView.addConstraints(format: "V:[v0(36)]-10-|", views: postButton)
        
        inputTextHeightConstraint = inputTextView.heightAnchor.constraint(equalToConstant: 36)
        inputTextHeightConstraint.isActive = true
    }
    
    @objc func handlePost() {
        inputTextView.text = ""
        textViewDidChange(inputTextView)
    }
    
}

extension InputViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let width = inputTextView.frame.width
        let height = inputTextView.sizeThatFits(CGSize(width: width, height: .infinity)).height
        
        if height > inputTextView.frame.height {
            if height < 166 {
                inputTextHeightConstraint.constant = height
                inputContainerHeightConstraint.constant = height + 20
            } else {
                inputTextView.isScrollEnabled = true
            }
        } else {
            inputTextHeightConstraint.constant = height > 36 ? height : 36
            inputContainerHeightConstraint.constant = height > 36 ? height + 20 : 56
            inputTextView.isScrollEnabled = false
        }
    }
    
}
