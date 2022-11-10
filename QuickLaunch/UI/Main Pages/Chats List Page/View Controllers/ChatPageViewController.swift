//
//  ChatPageViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 10.11.2022.
//

import UIKit

final class ChatPageViewController: UIViewController {
    
    //MARK: - Fields -
    
    private let chatUser: User
    
    //MARK: - Initialisation -
    
    init(user: User) {
        chatUser = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle -

extension ChatPageViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .purple
        navigationController?.title = "Chat #\(chatUser.id)"
    }
}
