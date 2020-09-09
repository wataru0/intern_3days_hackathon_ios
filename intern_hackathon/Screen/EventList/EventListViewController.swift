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
    
    // weak 消した
    //@IBOutlet var tableView: UITableView!
    var tableView: UITableView!
    var searchController = UISearchController()
    
    // APIレスポンスをデコードしたもの
    private var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(R.nib.eventListCell)
        tableView.dataSource = self
        tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        // searchBar 設置
        tableView.tableHeaderView = searchController.searchBar
        
        view.addSubview(tableView)
        
    }
    
    func searchEvents() {
        
    }
}

extension EventListViewController: UISearchResultsUpdating {
    // 文字が入力される度に呼ばれる
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
    
}

extension EventListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventListCell, for: indexPath),
            let event = events[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.set(event)
        return cell
    }
}

extension EventListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let urlString = events[safe: indexPath.row]?.eventURL,
            let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
