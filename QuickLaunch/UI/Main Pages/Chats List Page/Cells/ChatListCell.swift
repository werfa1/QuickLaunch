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
    private var userImageButton : UIButton!
    private var userEmailLabel  : UILabel!
    private var statusImageView : UIImageView!
    private var newMessageView  : UIView!
    private var newMessageLabel : UILabel!
    
    //MARK: - Fields -
    
    private var user: User!
    
    //MARK: - Callbacks -
    
    var onUserImageTapped: ((User) -> Void)?
    
    //MARK: - Initialisation -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUserImageView()
        configureUsernameLabel()
        configureNewMessageView()
        selectionStyle = .default
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Internal Methods -

extension ChatListCell {
    
    func setUserData(with user: User, numberOfNewMessages: Int) {
        self.user = user
        userImageButton.setImage(UIImage(named: user.imageName) ?? UIImage(systemName: "person"), for: .normal)
        userNameLabel.text = user.fullName
        
        if numberOfNewMessages == 0 {
            newMessageView.isHidden = true
            userNameLabel.font = .systemFont(ofSize: 17)
        } else {
            newMessageLabel.text = String(numberOfNewMessages)
            userNameLabel.font = .boldSystemFont(ofSize: 17)
            newMessageView.isHidden = false
        }
    }
}

//MARK: - Objective-C Methods -

extension ChatListCell {
    
    @objc
    private func handleShowingUserInfo() {
        onUserImageTapped?(user)
    }
}

//MARK: - UI Configuration -

extension ChatListCell {
    
    private func configureUserImageView() {
        userImageButton = UIButton()
        userImageButton.contentMode = .scaleAspectFill
        userImageButton.addTarget(self, action: #selector(handleShowingUserInfo), for: .touchUpInside)
        userImageButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userImageButton)
        
        NSLayoutConstraint.activate([
            userImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.leading),
            userImageButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageButton.widthAnchor.constraint(equalToConstant: Sizes.userImageSize),
            userImageButton.heightAnchor.constraint(equalToConstant: Sizes.userImageSize)
        ])
        
        userImageButton.layer.cornerRadius = Sizes.userImageSize / 2
        userImageButton.clipsToBounds = true
        userImageButton.layer.borderColor = UIColor.gray.cgColor
        userImageButton.layer.borderWidth = 1
    }
    
    private func configureUsernameLabel() {
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: userImageButton.trailingAnchor, constant: Paddings.leading),
            userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func configureNewMessageView() {
        newMessageView = UIView()
        newMessageView.translatesAutoresizingMaskIntoConstraints = false
        newMessageView.backgroundColor = .systemRed
        newMessageView.isHidden = true
        contentView.addSubview(newMessageView)
        NSLayoutConstraint.activate([
            newMessageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            newMessageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2 * Paddings.trailing),
            newMessageView.widthAnchor.constraint(equalToConstant: Sizes.newMessageViewSize),
            newMessageView.heightAnchor.constraint(equalToConstant: Sizes.newMessageViewSize)
        ])
        
        newMessageView.layer.cornerRadius = Sizes.newMessageViewSize / 2
        newMessageView.clipsToBounds = true
        
        newMessageLabel = UILabel()
        newMessageLabel.font = .systemFont(ofSize: 13)
        newMessageLabel.textColor = .white
        newMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        newMessageView.addSubview(newMessageLabel)
        
        NSLayoutConstraint.activate([
            newMessageLabel.centerXAnchor.constraint(equalTo: newMessageView.centerXAnchor),
            newMessageLabel.centerYAnchor.constraint(equalTo: newMessageView.centerYAnchor)
        ])
    }
}

//MARK: - Constants -

extension ChatListCell {
    
    private enum Paddings {
        
        /// 15
        static let leading  : CGFloat = 15
        
        /// 15
        static let trailing : CGFloat = 15
        
        /// 15
        static let vertical : CGFloat = 15
    }
    
    private enum Sizes {
        
        /// 35
        static let userImageSize        : CGFloat = 55
        
        /// 15
        static let newMessageViewSize   : CGFloat = 20
    }
}
