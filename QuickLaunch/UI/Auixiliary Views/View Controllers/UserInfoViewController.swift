//
//  UserInfoViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 10.11.2022.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    //MARK: - UI Elements -
    
    private var userImageView : UIImageView!
    private var userNameLabel : UILabel!
    private var userPhoneLabel: UILabel!
    private var userEmailLabel: UILabel!
    private var closeButton   : UIButton!
    
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
        view.backgroundColor = .white
        
        configureImageView()
    }
}

//MARK: - UI Configuration -

extension UserInfoViewController {
    
    private func configureImageView() {
        userImageView = UIImageView(image: UIImage(named: pickedUser.imageName))
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userImageView)
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userImageView.topAnchor.constraint(equalTo: view.topAnchor),
            userImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}

//MARK: - Constants -

extension UserInfoViewController {
    
    private enum Paddings {
        
        
//        static let
    }
    
    private enum Sizes {
        
//        static let imageViewHeight : CGFloat = 150
    }
}
