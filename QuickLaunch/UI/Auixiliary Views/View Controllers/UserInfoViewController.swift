//
//  UserInfoViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 10.11.2022.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    //MARK: - Fields -
    
    private let pickedUser: User
    
    //MARK: - Initialisation -
    
    init(pickedUser: User) {
        self.pickedUser = pickedUser
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle -

extension UserInfoViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemMint
    }
}
