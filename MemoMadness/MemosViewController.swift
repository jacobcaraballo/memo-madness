//
//  ViewController.swift
//  MemoMadness
//
//  Created by Jacob Caraballo on 10/18/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import UIKit


class MemosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var memosTableView = UITableView(frame: .zero, style: .grouped)
	var addButton = UIButton()
	var memos: [Memo] {
		return VirtualDatabase.shared.unpinnedMemos()
	}
	var pins: [Memo] {
		return VirtualDatabase.shared.pinnedMemos()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		layoutTableView()
		layoutButton()
	}
	
	func layoutTableView() {
		
		memosTableView.delegate = self
		memosTableView.dataSource = self
		memosTableView.translatesAutoresizingMaskIntoConstraints = false
		memosTableView.rowHeight = 60
		view.addSubview(memosTableView)
		
		NSLayoutConstraint.activate([
			
			memosTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
			memosTableView.heightAnchor.constraint(equalTo: view.heightAnchor),
			memosTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			memosTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			
			])
		
	}
	
	func layoutButton() {
		
		addButton.translatesAutoresizingMaskIntoConstraints = false
		addButton.layer.borderColor = UIColor.black.cgColor
		addButton.layer.borderWidth = 2
		addButton.layer.cornerRadius = 25
		addButton.layer.masksToBounds = true
		
		view.addSubview(addButton)
		
		NSLayoutConstraint.activate([
			
			addButton.widthAnchor.constraint(equalToConstant: 50),
			addButton.heightAnchor.constraint(equalToConstant: 50),
			addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(safeInsets.bottom + 20))
			
			])
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return pins.count != 0 ? 2 : 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if pins.count != 0 {
			return section == 0 ? pins.count : memos.count
		} else {
			return memos.count
		}
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let pinAction = UIContextualAction(style: .normal, title: "Pin") { (action, view, completionHandler) in
			
		}
		
		return UISwipeActionsConfiguration(actions: [pinAction])
		
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
			
		}
		
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
			
		}
		
		return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
	}
	
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if pins.count != 0 {
			return section == 0 ? "Pinned Notes" : "Notes"
		} else {
			return "Notes"
		}
	}
	
	
	
	


}

