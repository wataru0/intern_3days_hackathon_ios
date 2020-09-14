//
//  BookmarkItem.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/14.
//  Copyright © 2020 caraquri. All rights reserved.
//

import Foundation
import RealmSwift

class BookmarkItem: Object {
    @objc dynamic var id: String = NSUUID().uuidString //primary key
    @objc dynamic var booked: Bool = false
    @objc dynamic var eventID: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var adress: String = ""
    
   override static func primaryKey() -> String? {
       return "id"
   }
}
