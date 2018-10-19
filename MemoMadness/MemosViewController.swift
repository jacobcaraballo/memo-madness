//
//  ViewController.swift
//  MemoMadness
//
//  Created by Jacob Caraballo on 10/18/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import UIKit


class MemosViewController: UIViewController {
	
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		memosTableView.reloadData()
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
		addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
		addButton.setTitle("+", for: .normal)
		addButton.setTitleColor(.black, for: .normal)
		addButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .light)
		addButton.contentVerticalAlignment = .center
		view.addSubview(addButton)
		
		NSLayoutConstraint.activate([
			
			addButton.widthAnchor.constraint(equalToConstant: 50),
			addButton.heightAnchor.constraint(equalToConstant: 50),
			addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(safeInsets.bottom + 20))
			
			])
		
	}
	
	@objc func addButtonPressed() {
		let vc = MemoEditViewController()
		present(vc, animated: true, completion: nil)
	}
	

}



// TableView delegates and datasource functions
extension MemosViewController: UITableViewDelegate, UITableViewDataSource {
	
	func getMemo(at indexPath: IndexPath) -> Memo {
		
		if pins.count != 0 {
			return indexPath.section == 0 ? pins[indexPath.row] : memos[indexPath.row]
		} else {
			return memos[indexPath.row]
		}
		
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
		var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "MemoCell")
		
		if cell == nil {
			cell = UITableViewCell(style: .default, reuseIdentifier: "MemoCell")
		}
		
		let memo = getMemo(at: indexPath)
		cell.textLabel?.text = memo.note
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let memo = getMemo(at: indexPath)
		let pinAction = UIContextualAction(style: .normal, title: memo.pinned ? "Unpin" : "Pin") { (action, view, completionHandler) in
			memo.pinned = !memo.pinned
			UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
				tableView.reloadData()
			}, completion: nil)
			completionHandler(false)
		}
		
		return UISwipeActionsConfiguration(actions: [pinAction])
		
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let memo = getMemo(at: indexPath)
		
		let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
			let vc = MemoEditViewController()
			vc.memo = memo
			self.present(vc, animated: true, completion: nil)
			completionHandler(false)
		}
		
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
			VirtualDatabase.shared.removeMemo(memo: memo)
			completionHandler(true)
		}
		
		
		return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let memo = getMemo(at: indexPath)
		let vc = MemoEditViewController()
		vc.memo = memo
		present(vc, animated: true, completion: nil)
	}
	
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if pins.count != 0 {
			return section == 0 ? "Pinned Notes" : "Notes"
		} else {
			return "Notes"
		}
	}
	
	
}
