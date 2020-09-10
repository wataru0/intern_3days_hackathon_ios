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
    
    func set(_ event: Event) {
        titleTextLabel.text = event.title
        descriptionTextLabel.text = "開催地: " + String(event.address ?? "")
    }
}
