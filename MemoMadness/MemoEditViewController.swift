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
	

	override func viewDidLoad() {
		super.viewDidLoad()
		layoutTextView()
	}
	
	func layoutTextView() {
		
		textView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(textView)
		
		NSLayoutConstraint.activate([
			
			textView.widthAnchor.constraint(equalTo: view.widthAnchor),
			textView.heightAnchor.constraint(equalTo: view.heightAnchor),
			textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			textView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			
			])
		
	}
	
	
	
}
