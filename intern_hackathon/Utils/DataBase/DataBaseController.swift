//
//  DataBaseController.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/14.
//  Copyright © 2020 caraquri. All rights reserved.
//

import RealmSwift
import UIKit

class DataBaseController {
    private var realm: Realm!
    private var bookmarks: Results<BookmarkItem>!
    // DBへの追加
    func addBookmark(eventID: Int) {
        
        try? realm.write {
            realm.add(BookmarkItem(value: ["booked": true, "eventID": eventID]))
        }
    }
    
    // DBから削除
    func deleteBookmark(index: Int) {
        try? realm.write {
            realm.delete(bookmarks[index])
        }
    }
}
