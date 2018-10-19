//
//  MemoEditViewController.swift
//  MemoMadness
//
//  Created by Jacob Caraballo on 10/18/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import Foundation
import UIKit

class MemoEditViewController: UIViewController, UITextViewDelegate {
	
	private let textView = UITextView()
	var memo: Memo!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		layoutTextView()
		layoutToolbar()
		textView.becomeFirstResponder()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		textView.text = memo?.note
	}
	
	
	func layoutTextView() {
		
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.textContainerInset = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height + 20, left: 20, bottom: 20, right: 20)
		textView.font = UIFont.systemFont(ofSize: 25)
		view.addSubview(textView)
		
		NSLayoutConstraint.activate([
			
			textView.widthAnchor.constraint(equalTo: view.widthAnchor),
			textView.heightAnchor.constraint(equalTo: view.heightAnchor),
			textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			
			])
		
	}
	
	
	func layoutToolbar() {
		
		let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 1, height: 44))
		toolbar.tintColor = .black
		toolbar.autoresizingMask = .flexibleWidth
		toolbar.items = [
			UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel)),
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		]
		
		textView.inputAccessoryView = toolbar
		
	}
	
	
	@objc func cancel() {
		view.endEditing(true)
		dismiss(animated: true, completion: nil)
	}
	
	@objc func done() {
		
		if memo == nil {
			memo = Memo(note: textView.text)
		} else {
			memo.note = textView.text
		}
		
		view.endEditing(true)
		dismiss(animated: true, completion: nil)
	}
	
	
}
