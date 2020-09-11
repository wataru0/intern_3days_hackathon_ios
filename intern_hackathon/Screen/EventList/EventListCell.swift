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
    @IBOutlet weak var bookmarkButton: UIButton!
    
    // ブックマーク情報を保持する
    let userDefaults = UserDefaults.standard
    
    //var bookmark: BookmarkCellData?
    
    // buttonの状態，true:押されている
    var bFlag: Bool = false
    
    func set(_ event: Event) {
        titleTextLabel.text = event.title
        descriptionTextLabel.text = "開催地: " + String(event.address ?? "")
        
        // bookmarkされていたらスイッチオン
        if userDefaults.bool(forKey: String(self.tag)) {
            bookmarkSwitch.setOn(true, animated: false)
            bookmarkButton.setImage(UIImage(named: "bookOn"), for: .normal)
        } else {
            bookmarkSwitch.setOn(false, animated: false)
            bookmarkButton.setImage(UIImage(named: "bookOff"), for: .normal)
        }
        
        // icon設定
        let url = "https://connpass.com/static/img/468_468.png"
        guard let iconUrl = URL(string: url) else { return }
        let options = ImageLoadingOptions(
            contentModes: .init(success: .scaleAspectFit, failure: .center, placeholder: .center))
        Nuke.loadImage(with: iconUrl, options: options, into: iconImageView)
    }

    // bookmarkをセットする関数
//    func set(_ bookmark: BookmarkCellData) {
//        self.bookmark = bookmark
//        titleTextLabel.text = bookmark.title
//        descriptionTextLabel.text = "開催地: " + bookmark.address
//
//        // bookmarkスイッチ ON にする
//        bookmarkSwitch.setOn(true, animated: false)
//
//    }
    
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        bFlag = !bFlag
        if bFlag {
            bookmarkButton.setImage(UIImage(named: "bookOn"), for: .normal)
            
            // eventIDとそのスイッチの情報をuserDefaultsに保存
            // すでに他のeventID格納されている場合
            if UserDefaults.standard.array(forKey: "bookmarks") != nil {
                guard var bookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [Int] else { return }
                bookmarks.append(self.tag)
                userDefaults.set(bookmarks, forKey: "bookmarks")
            } else {
                var bookmarks: [Int] = []
                bookmarks.append(self.tag)
                userDefaults.set(bookmarks, forKey: "bookmarks")
            }
            
            userDefaults.set(true, forKey: String(self.tag))

        } else {
            bookmarkButton.setImage(UIImage(named: "bookOff"), for: .normal)
            
            // UserDefaultskからeventID配列取り出し
           guard var bookmarks = userDefaults.array(forKey: "bookmarks") as? [Int] else { return }
            guard let index = bookmarks.firstIndex(of: self.tag) else { return }
            // 配列から削除
            bookmarks.remove(at: index)
            
            // 値更新
            userDefaults.set(bookmarks, forKey: "bookmarks")
            
            // userDefaultsにボタンを操作した記事のeventID保存されていたら削除
//            if userDefaults.bool(forKey: String(self.tag)) {
//                userDefaults.removeObject(forKey: String(self.tag))
//                
//                // UserDefaultskからeventID配列取り出し
//                guard var bookmarks = userDefaults.array(forKey: "bookmarks") as? [Int] else { return }
//                
//                // index取得
//                guard let index = bookmarks.firstIndex(of: self.tag) else { return }
//                bookmarks.remove(at: index)
//                
//                // 値更新
//                userDefaults.set(bookmarks, forKey: "bookmarks")
//            }
            
            userDefaults.set(false, forKey: String(self.tag))
        }
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        // UISwitchのon/off判定
        if sender.isOn {
            print("on")
            print(self.tag)
            
            // eventIDとそのスイッチの情報をuserDefaultsに保存
            // すでに格納されている場合
            if UserDefaults.standard.array(forKey: "bookmarks") != nil {
                guard var bookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [Int] else { return }
                bookmarks.append(self.tag)
                userDefaults.set(bookmarks, forKey: "bookmarks")
            } else {
                var bookmarks: [Int] = []
                bookmarks.append(self.tag)
                userDefaults.set(bookmarks, forKey: "bookmarks")
            }
            //guard var bookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [Int] else { return }
            
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
