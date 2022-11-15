//
//  ViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 09.11.2022.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    //MARK: - UI Elements -
    
    private var tableView: UITableView!
    
    //MARK: - Fields -
    
    private var userList: [User]
    
    //MARK: - Properties -
    
    //MARK: - Initialisation -
    
    init() {
        userList = [
            User(id: 1, name: "Paul Johnson", email: "", phone: ""),
            User(id: 2, name: "Dominic Toretto", email: "", phone: ""),
            User(id: 3, name: "Dwayne Johnson", email: "", phone: ""),
            User(id: 4, name: "Jack Black", email: "", phone: ""),
            User(id: 5, name: "Jason Statham", email: "", phone: "")
        ]
            super.init(nibName: nil, bundle: nil)
     }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle -

extension ChatListViewController {
    override func loadView() {
        view = tableView
        
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Chats"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.title = "chats"
    }
}

//MARK: - UITableView DataSource -

extension ChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier) as! ChatListCell
        cell.setUserData(with: userList[indexPath.row], numberOfNewMessages: indexPath.row)
        cell.onUserImageTapped = { [weak self] pickedUser in
            let userInfoVC = UserInfoViewController(pickedUser: pickedUser)
            self?.present(userInfoVC, animated: true)
        }
        return cell
    }
}

//MARK: - UITableView Delegate -

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatPageVC = ChatPageViewController(user: userList[indexPath.row])
        navigationController?.pushViewController(chatPageVC, animated: true)
    }
}

//MARK: - UI Configuration -

extension ChatListViewController {
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.identifier)
        tableView.rowHeight = Sizes.rowHeight
    }
}

//MARK: - Constants -

extension ChatListViewController {
    
    private enum Sizes {
        
        /// 50
        static let rowHeight: CGFloat = 70
    }
}

