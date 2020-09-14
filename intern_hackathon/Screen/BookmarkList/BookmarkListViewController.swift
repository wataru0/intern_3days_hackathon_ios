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
    
    private var bookmarkIDs: [Int] = []
    
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        tableView.register(R.nib.bookmarkListCell)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let voidView = UIView()
        voidView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: barHeight)
        
        tableView.tableHeaderView = voidView
        
        print("--viewDidLoad--")
        
        NotificationCenter.default.addObserver(self, selector: #selector(book(notification:)), name: .book, object: nil)
    }
    
    @objc func book(notification: NSNotification?) {
        guard let userinfo = notification?.userInfo,
            let tag = userinfo["id"] as? Int, let bFlag: Bool = userinfo["flag"] as? Bool else { return }
        
        if bFlag {
            
            bookmarkIDs.append(tag)
            userDefaults.set(true, forKey: String(tag))
            
        } else {
            
            // この書き方，重要．業務でも使うらしい．
            if let index = bookmarkIDs.firstIndex(where: { $0 == tag }) {
                bookmarkIDs.remove(at: index)
            }
            userDefaults.set(false, forKey: String(tag))
        }
        
        userDefaults.set(bookmarkIDs, forKey: "bookmarks")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let eventIDs = UserDefaults.standard.array(forKey: "bookmarks") as? [Int] else { return }
        
        //searchEvents(eventIDs)
        
        print("--viewWillAppear--")
        print(eventIDs)
        
        guard let bookmarks = userDefaults.array(forKey: "bookmarks") as? [Int] else { return }
        bookmarkIDs = bookmarks
        
        searchEvents(bookmarks)
        tableView.reloadData()
        
    }
    // tabで遷移したときにviewWillAppear系が呼ばれない
    
    func searchEvents(_ eventIDs: [Int]) {
        APIClient.fetchEventsByEventID(eventID: eventIDs) { [weak self] result in
            // URLSessionはbackground threadで行われる為UIの更新を明示的にMain Theadで行う
            DispatchQueue.main.sync {
                switch result {
                case .success(let events):
                    self?.events = events
                    self?.tableView.reloadData()
                    
                case .failure(let error):
                    let alert = UIAlertController.createErrorAlert(error)
                    self?.present(alert, animated: true)
                    
                }
            }
        }
    }
}

extension BookmarkListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // セル作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.bookmarkListCell.identifier, for: indexPath) as? BookmarkListCell,
            let event = events[safe: indexPath.row]  else { return UITableViewCell() }
        
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
