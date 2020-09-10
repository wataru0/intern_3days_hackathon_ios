//
//  EventListCell.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/09.
//  Copyright © 2020 caraquri. All rights reserved.
//
import Nuke
import UIKit

class EventListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var bookmarkSwitch: UISwitch!
    
    // ブックマーク情報を保持する
    let userDefaults = UserDefaults.standard
    
    public var bookmarks: [Int]?
    
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
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        // UISwitchのon/off判定
        if sender.isOn {
            print("on")
            print(self.tag)
            
            // eventIDとそのスイッチの情報をuserDefaultsに保存
            bookmarks?.append(self.tag)
            userDefaults.set(bookmarks, forKey: "bookmarks")
            userDefaults.set(true, forKey: String(self.tag))
            
        } else {
            print("off")
            // userDefaultsに保存されていたら削除
            if userDefaults.bool(forKey: String(self.tag)) {
                userDefaults.removeObject(forKey: String(self.tag))
                
                if bookmarks?.firstIndex(of: self.tag) != nil {
                    
                }
                guard let index = bookmarks?.firstIndex(of: self.tag) else { return }
                bookmarks?.remove(at: index)
                userDefaults.set(bookmarks, forKey: "bookmarks")
            }
        }
    }
    
}
