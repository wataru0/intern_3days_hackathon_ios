//
//  EventListCell.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/09.
//  Copyright © 2020 caraquri. All rights reserved.
//
import Foundation
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
    @IBOutlet weak var bookmarkButton: UIButton!
    
    // ブックマーク情報を保持する
    let userDefaults = UserDefaults.standard
    
    // buttonの状態，true:押されている
    var bFlag: Bool = false
    
    func set(_ event: Event) {
        titleTextLabel.text = event.title
        descriptionTextLabel.text = "開催地: " + String(event.address ?? "")
        
        // bookmarkされていたらスイッチオン
        if userDefaults.bool(forKey: String(self.tag)) {
            bookmarkButton.setImage(UIImage(named: "bookOn"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(named: "bookOff"), for: .normal)
        }
        
        // icon設定
        let url = "https://connpass.com/static/img/468_468.png"
        guard let iconUrl = URL(string: url) else { return }
        let options = ImageLoadingOptions(
            contentModes: .init(success: .scaleAspectFit, failure: .center, placeholder: .center))
        Nuke.loadImage(with: iconUrl, options: options, into: iconImageView)
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        bFlag = !bFlag
        
        NotificationCenter.default.post(name: .event, object: nil, userInfo: ["id": tag, "flag": bFlag])
        
        if bFlag {
            bookmarkButton.setImage(UIImage(named: "bookOn"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(named: "bookOff"), for: .normal)
        }
    }
}
