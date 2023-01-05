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
    
    //MARK: - Fields -
    
    private let currentUser: User
    
    //MARK: - Initialisation -
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle -

extension SettingsViewController {
    
    override func loadView() {
        view = tableView
        
        configureTableView()
        view.backgroundColor = .white
        title = "Settings"
    }
}

//MARK: - UITableView DataSource -

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInfoCell.identifier) as! PersonalInfoCell
        cell.setPersonalInfo(for: currentUser)
        return cell
    }
}

//MARK: - UITableView Delegate -

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - UI Configuration -

extension SettingsViewController {
    private func configureTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(PersonalInfoCell.self, forCellReuseIdentifier: PersonalInfoCell.identifier)
    }
}
