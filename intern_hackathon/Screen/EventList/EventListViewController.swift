//
//  EventListViewController.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/09.
//  Copyright © 2020 caraquri. All rights reserved.
//
//import BTNavigationDropdownMenu
import Parchment
import SafariServices
import UIKit

class EventListViewController: UIViewController {
    
    var tableView: UITableView!
    var searchController = UISearchController()
    var searchBar: UISearchBar!
    
    // APIレスポンスをデコードしたもの
    private var events: [Event] = []
    
    let userDefaults = UserDefaults.standard
    
    private var bookmarkIDs: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // iOS13未満
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        tableView.register(R.nib.eventListCell)
        tableView.dataSource = self
        tableView.delegate = self
        
        // searchBarの作成
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        //大きさの指定
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: barHeight)
        //キャンセルボタンの追加
        searchBar.showsCancelButton = true
        searchBar.placeholder = "キーワードを入力"
        
        // searchBar 設置
        tableView.tableHeaderView = searchBar
        
        view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(book(notification:)), name: .event, object: nil)
    }
    
    @objc func book(notification: NSNotification?) {
        guard let userinfo = notification?.userInfo,
            let tag = userinfo["id"] as? Int, let bFlag: Bool = userinfo["flag"] as? Bool else { return }
        
        if bFlag {
            bookmarkIDs.append(tag)
        } else {
            
            if let index = bookmarkIDs.firstIndex(where: { $0 == tag }) {
                bookmarkIDs.remove(at: index)
            }
        }
        
        userDefaults.set(bookmarkIDs, forKey: "bookmarks")
        userDefaults.set(true, forKey: String(tag))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        guard let bookmarks = userDefaults.array(forKey: "bookmarks") as? [Int] else { return }
        bookmarkIDs = bookmarks
    }
    
    // searchBarに入力された文字列で検索する
    func searchEvents(_ searchText: String) {
        APIClient.fetchEvents(keyword: searchText) { [weak self] result in
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

extension EventListViewController: UISearchBarDelegate {
    // searchBarのテキストが変更される度に呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchEvents(searchText)
    }
}

extension EventListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // セル作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.eventListCell.identifier, for: indexPath) as? EventListCell,
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

extension EventListViewController: UITableViewDelegate {
    
    // セル選択した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let urlString = events[safe: indexPath.row]?.eventURL,
            let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
