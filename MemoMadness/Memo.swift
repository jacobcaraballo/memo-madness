//
//  Memo.swift
//  MemoMadness
//
//  Created by Jacob Caraballo on 10/18/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import Foundation

class Memo {
	
	let id = UUID()
	let creationDate = Date()
	var pinned = false
	var note: String
	
	init(note: String) {
		self.note = note
	}
	
}
