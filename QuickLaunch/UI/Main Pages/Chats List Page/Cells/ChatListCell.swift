//
//  ChatListCell.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 09.11.2022.
//

import UIKit

final class ChatListCell: UITableViewCell {
    
    //MARK: - Identifier -
    
    static let identifier = String(describing: ChatListCell.self)
    
    //MARK: - UI Elements -
    
    private var userNameLabel   : UILabel!
    private var userImageView   : UIImageView!
    private var userEmailLabel  : UILabel!
    private var statusImageView : UIImageView!
    
    //MARK: - Initialisation -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUserImageView()
        configureUsernameLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Internal Methods -

extension ChatListCell {
    
    func setUserData(with user: User) {
        userNameLabel.text = user.fullName
    }
}

//MARK: - UI Configuration -

extension ChatListCell {
    
    private func configureUserImageView() {
        userImageView = UIImageView(image: UIImage(systemName: "person"))
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userImageView)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.leading),
            userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: Sizes.userImageSize),
            userImageView.heightAnchor.constraint(equalToConstant: Sizes.userImageSize)
        ])
    }
    
    private func configureUsernameLabel() {
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: Paddings.leading),
            userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

//MARK: - Constants -

extension ChatListCell {
    
    private enum Paddings {
        
        /// 15
        static let leading : CGFloat = 15
    }
    
    private enum Sizes {
        
        /// 30
        static let userImageSize: CGFloat = 30
    }
}
