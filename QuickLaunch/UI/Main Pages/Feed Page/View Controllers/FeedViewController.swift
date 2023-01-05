//
//  FeedViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 15.11.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    
}

//MARK: - Lifecycle -

extension FeedViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
    }
}
