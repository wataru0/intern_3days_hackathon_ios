//
//  SearchViewController.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/09.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    var searchController = UISearchController()
    var searchBar: UISearchBar {
        searchController.searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
    }
    
    func setSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "検索したいキーワード"
        
        //UISearchTextField
        //searchBar.searchTextField.backgroundColor = .systemGray
    }
    
    // UISearchResultsUpdatingのプロトコル，文字入力される度に呼ばれる．
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
}
