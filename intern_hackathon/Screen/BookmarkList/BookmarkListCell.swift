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

final class BookmarkListCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    // ブックマーク情報を保持する
    private let userDefaults = UserDefaults.standard
    
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
        let iconurl = "https://connpass.com/static/img/468_468.png"
        
        //  画像の貼り付け
        setIcon(iconurl)
    }
    
    func setIcon(_ url: String) {
        guard let iconURL = URL(string: url) else { return }
        let options = ImageLoadingOptions(
            contentModes: .init(success: .scaleAspectFit, failure: .center, placeholder: .center))
        Nuke.loadImage(with: iconURL, options: options, into: iconImageView)
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        // flg へんこう
        // idを通知する
        bFlag = !bFlag
        
        NotificationCenter.default.post(name: .book, object: nil, userInfo: ["id": tag, "flag": bFlag])
        
        if bFlag {
            bookmarkButton.setImage(UIImage(named: "bookOn"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(named: "bookOff"), for: .normal)
        }
    }
}
