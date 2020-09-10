//
//  EventListCell.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/09.
//  Copyright © 2020 caraquri. All rights reserved.
//
import Nuke
import UIKit

struct BookmarkCellData {
    var eventId: Int
    var title: String
    var address: String
    var url: String
}

class EventListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var bookmarkSwitch: UISwitch!
    
    // ブックマーク情報を保持する
    let userDefaults = UserDefaults.standard
    
    var bookmark: BookmarkCellData?
    
    func set(_ event: Event) {
        titleTextLabel.text = event.title
        descriptionTextLabel.text = "開催地: " + String(event.address ?? "")
        
        // bookmarkされていたらスイッチオン
        if userDefaults.bool(forKey: String(self.tag)) {
            bookmarkSwitch.setOn(true, animated: false)
        } else {
            bookmarkSwitch.setOn(false, animated: false)
        }
        
    }
    
    // bookmarkをセットする関数
    func set(_ bookmark: BookmarkCellData) {
        self.bookmark = bookmark
        titleTextLabel.text = bookmark.title
        descriptionTextLabel.text = "開催地: " + bookmark.address
        
        // bookmarkスイッチ ON にする
        bookmarkSwitch.setOn(true, animated: false)
        
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        // UISwitchのon/off判定
        if sender.isOn {
            print("on")
            print(self.tag)
            
            // eventIDとそのスイッチの情報をuserDefaultsに保存
            guard var bookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [Int] else { return }
            bookmarks.append(self.tag)
            userDefaults.set(bookmarks, forKey: "bookmarks")
            
            // eventIDにブックマーク情報を紐付け
            userDefaults.set(true, forKey: String(self.tag))
            
//            guard let title = self.titleTextLabel.text else { return }
//            guard let adress = self.descriptionTextLabel.text else { return }
//            let book = BookmarkCellData(eventId: self.tag, title: title, address: adress, url: <#T##String#>)
            
        } else {
            print("off")
            // userDefaultsに保存されていたら削除
            if userDefaults.bool(forKey: String(self.tag)) {
                userDefaults.removeObject(forKey: String(self.tag))
                
                guard var bookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [Int] else { return }
//                if bookmarks.firstIndex(of: self.tag) != nil {
//
//                }
                guard let index = bookmarks.firstIndex(of: self.tag) else { return }
                bookmarks.remove(at: index)
                userDefaults.set(bookmarks, forKey: "bookmarks")
            }
        }
    }
    
}
