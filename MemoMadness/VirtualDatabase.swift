//
//  VirtualDatabase.swift
//  MemoMadness
//
//  Created by Jacob Caraballo on 10/18/18.
//  Copyright © 2018 Jacob Caraballo. All rights reserved.
//

import Foundation


// this is a virtual database that only persists during the lifetime of the application
// the data is cleared when the app is terminated
class VirtualDatabase {
	
	static var shared = VirtualDatabase()
	private var memos = [Memo]()
	
	func addMemo(memo: Memo) {
		memos.append(memo)
	}
	
	func removeMemo(memo: Memo) {
		guard let index = memos.firstIndex(where: { $0.id == memo.id }) else { return }
		memos.remove(at: index)
	}
	
	func allMemos() -> [Memo] {
		return memos
	}
	
	func pinnedMemos() -> [Memo] {
		return memos.filter({ $0.pinned })
	}
	
	func unpinnedMemos() -> [Memo] {
		return memos.filter({ !$0.pinned })
	}
	
}
