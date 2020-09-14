//
//  Notification+extensions.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/11.
//  Copyright © 2020 caraquri. All rights reserved.
//

import Foundation

// Notificationを使うと子から親へ値を送ったりすることができる．
// 値を送れる．
extension Notification.Name {
    static let event = Notification.Name("event")
    static let book = Notification.Name("book")
}
