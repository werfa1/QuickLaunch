//
//  SettingsViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 15.11.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - UI Elements -
    
    private var tableView: UITableView!
}

//MARK: - Lifecycle -

extension SettingsViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemPink
    }
}
