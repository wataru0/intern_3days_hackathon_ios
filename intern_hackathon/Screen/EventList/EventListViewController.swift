//
//  EventListViewController.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/09.
//  Copyright © 2020 caraquri. All rights reserved.
//
import SafariServices
import UIKit

class EventListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController()
    
    // APIレスポンスをデコードしたもの
    private var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height))
        
    }
}
