//
//  BookmarkListViewController.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/10.
//  Copyright © 2020 caraquri. All rights reserved.
//
import SafariServices
import UIKit

class BookmarkListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(R.nib.eventListCell)
        // UITableViewのdelegateらを受け持つ
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension BookmarkListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // セル作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventListCell, for: indexPath),
            let event = events[safe: indexPath.row] else { return UITableViewCell() }
        
        // セルのタグにevent_idを登録
        guard let eventID: Int = event.eventID else {
            return UITableViewCell()
        }
        cell.tag = eventID
        
        cell.set(event)
        return cell
    }
}

extension BookmarkListViewController: UITableViewDelegate {
    
    // セル選択した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let urlString = events[safe: indexPath.row]?.eventURL,
            let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
