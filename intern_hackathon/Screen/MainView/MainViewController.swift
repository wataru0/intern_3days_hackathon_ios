//
//  MainViewController.swift
//  intern_hackathon
//
//  Created by 岡本航昇 on 2020/09/10.
//  Copyright © 2020 caraquri. All rights reserved.
//
import Parchment
import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parchmentを使って，tabでViewControllerを切り替えられるようにする
        let mainSB: UIStoryboard = UIStoryboard(name: "EventList", bundle: nil)
        guard let mainViewController = mainSB.instantiateInitialViewController() else { return }
        mainViewController.title = "main"
        
        let bookmarkSB: UIStoryboard = UIStoryboard(name: "BookmarkList", bundle: nil)
        guard let bookmarkViewController = bookmarkSB.instantiateInitialViewController() else { return }
        bookmarkViewController.title = "bookmarks"
        
        let pagingViewController = PagingViewController(viewControllers: [mainViewController, bookmarkViewController])
        
        // viewに追加
        self.addChild(pagingViewController)
        self.view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pagingViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pagingViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pagingViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pagingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
}
