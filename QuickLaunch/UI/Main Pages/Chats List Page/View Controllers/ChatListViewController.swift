//
//  ViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 09.11.2022.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    //MARK: - UI Elements -
    
    private var tableView   : UITableView!
    private var loader      : UIActivityIndicatorView!
    private var reloadButton: UIButton!
    
    //MARK: - Constraints -
    
    private var reloadButtonTopConstraint: NSLayoutConstraint!
    
    //MARK: - Fields -
    
    private let userService : UserServiceProtocol
    
    private var userList    : [User] = []
    
    //MARK: - Properties -
    
    //MARK: - Initialisation -
    
    init() {
//        userList = [
//            User(id: 1, name: "Paul Johnson", email: "", phone: ""),
//            User(id: 2, name: "Dominic Toretto", email: "", phone: ""),
//            User(id: 3, name: "Dwayne Johnson", email: "", phone: ""),
//            User(id: 4, name: "Jack Black", email: "", phone: ""),
//            User(id: 5, name: "Jason Statham", email: "", phone: "")
//        ]
        userService = UserService()
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
        view = UIView()
        tableView = UITableView()
        view.addSubview(tableView)
        
        configureTableView()
        configureLoader()
        configureReloadButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        setLoader(forState: .on)
        fetchUserList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.title = "chats"
    }
}

//MARK: - Fetch Data -

extension ChatListViewController {
    
    private func fetchUserList() {
        Task {
            do {
                userList = try await userService.fetchUsers()
                
                // Update UI from the main thread
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if self.userList.count > 0 {
                        self.updateUI(forLoadedState: .successfullyLoaded)
                    } else {
                        self.updateUI(forLoadedState: .zeroData)
                    }
                }
            } catch {
                userList = []
                DispatchQueue.main.async { [weak self] in
                    self?.updateUI(forLoadedState: .failed)
                }
            }
        }
    }
}

//MARK: - Objective-C Methods -

extension ChatListViewController {
    @objc
    private func handleReloadButtonTap() {
        UIView.animate(withDuration: 0.3) {
            self.setReloadButton(forState: .off)
            self.setLoader(forState: .on)
        }
        fetchUserList()
    }
}

//MARK: - UI Update -

extension ChatListViewController {
    private func updateUI(forLoadedState state: LoadedState) {
        if state == .successfullyLoaded {
            tableView.alpha = 1
            tableView.reloadData()
            setLoader(forState: .off)
            return
        }
        
        let description = state == .failed ? "Failed to fetch users" : "No data to display"
        let title = description + ".\n" + "Tap to reload"
        reloadButton.setTitle(title, for: .normal)
        tableView.alpha = 0
        setReloadButton(forState: .on)
        setLoader(forState: .off)
    }
    
    private func setLoader(forState state: SwitchState) {
        switch state {
        case .on:
            UIView.animate(withDuration: 0.3) {
                self.loader.startAnimating()
                self.loader.alpha = 1
            }
        case .off:
            UIView.animate(withDuration: 0.3) {
                self.loader.alpha = 0
                self.loader.stopAnimating()
            }
        }
    }
    
    private func setReloadButton(forState state: SwitchState) {
        switch state {
        case .on:
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseOut) {
                    self.reloadButtonTopConstraint.constant = Paddings.reloadButtonVisibleTop
                    self.reloadButton.alpha = 1
                    self.view.layoutIfNeeded()
                }
        case .off:
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseIn) {
                    self.reloadButton.alpha = 0
                    self.reloadButtonTopConstraint.constant = Paddings.reloadButtonHiddenTop
                    self.view.layoutIfNeeded()
                }
        }
    }
}

//MARK: - UITableView DataSource -

extension ChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier) as! ChatListCell
        let user = userList[indexPath.row]
        user.imageName = "user" + String(indexPath.row)
        cell.setUserData(
            with: userList[indexPath.row],
            numberOfNewMessages: Int.random(in: 0...3))
        
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.identifier)
        tableView.rowHeight = Sizes.rowHeight
    }
    
    private func configureLoader() {
        loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: Sizes.loaderSize),
            loader.heightAnchor.constraint(equalToConstant: Sizes.loaderSize)
        ])
    }
    
    private func configureReloadButton() {
        reloadButton = UIButton()
        reloadButton.titleLabel?.numberOfLines = 2
        reloadButton.titleLabel?.font = .italicSystemFont(ofSize: 18)
        reloadButton.titleLabel?.textAlignment = .center
        reloadButton.setTitleColor(.gray, for: .normal)
        reloadButton.setTitleColor(.lightGray, for: .highlighted)
        reloadButton.addTarget(self, action: #selector(handleReloadButtonTap), for: .touchUpInside)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButtonTopConstraint = reloadButton.topAnchor.constraint(equalTo: tableView.topAnchor, constant: Paddings.reloadButtonHiddenTop)
        view.addSubview(reloadButton)
        NSLayoutConstraint.activate([
            reloadButtonTopConstraint,
            reloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.horizontal),
            reloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.horizontal)
        ])
    }
}

//MARK: - Constants -

extension ChatListViewController {
    
    private enum Sizes {
        
        /// 70
        static let rowHeight  : CGFloat = 90
        
        /// 40
        static let loaderSize : CGFloat = 40
    }
    
    private enum Paddings {
        
        /// 70
        static let reloadButtonVisibleTop: CGFloat = 200
        
        /// 50
        static let reloadButtonHiddenTop : CGFloat = 130
        
        /// 40
        static let horizontal            : CGFloat = 40
    }
}

