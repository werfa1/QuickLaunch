//
//  PersonalInfoCell.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 16.11.2022.
//

import UIKit

final class PersonalInfoCell: UITableViewCell {
    
    //MARK: - Identifier -
    
    static let identifier = String(describing: PersonalInfoCell.self)
    
    //MARK: - UI Elements -
    
    private var userImageView   : UIImageView!
    private var firstNameLabel  : UILabel!
    private var lastNameLabel   : UILabel!
    private var emailLabel      : UILabel!
    private var phoneLabel      : UILabel!
    private var mainStack       : UIStackView!
    private var showLabel       : UILabel!
    private var chevronImageView: UIImageView!
    private var expandStack     : UIStackView!
    
    //MARK: - Fields -
    
    private var isExpanded = false
    
    //MARK: - Initialisation -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //configureMainStack()
        configureExpandStack()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Internal Functions -

extension PersonalInfoCell {
    
    func setPersonalInfo(for user: User) {
//        firstNameLabel.text = "First Name: " + user.firstName
//        lastNameLabel.text  = "Last Name: " + user.lastName
//        emailLabel.text     = "Email: " + user.email
//        phoneLabel.text     = "Phone: " + user.phone
    }
}

//MARK: - Objective-C Methods-

extension PersonalInfoCell {
    
    @objc
    private func handleExpandingInfo() {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.showLabel.text = self.isExpanded ? ExpandedState.showLess.rawValue : ExpandedState.showMore.rawValue
//            self.phoneLabel.isHidden = self.isExpanded ? false : true
//            self.emailLabel.isHidden = self.isExpanded ? false : true
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: self.isExpanded ? .pi : 0.0001)
        }
    }
}

//MARK: - UI Configuration -

extension PersonalInfoCell {
    
    private func configureMainStack() {
        userImageView = UIImageView(image: UIImage(systemName: "person.fill"))
        
        firstNameLabel = UILabel()
        lastNameLabel = UILabel()
        emailLabel = UILabel()
        phoneLabel = UILabel()
        emailLabel.isHidden = true
        phoneLabel.isHidden = true
        
        mainStack = UIStackView(arrangedSubviews: [userImageView, firstNameLabel, lastNameLabel, emailLabel, phoneLabel])
        mainStack.axis = .vertical
        mainStack.distribution = .fill
        mainStack.alignment = .center
        mainStack.spacing = Paddings.vertical
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.horizontal),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Paddings.horizontal),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Paddings.vertical),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Paddings.vertical)
        ])
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: Sizes.userImageSize),
            userImageView.heightAnchor.constraint(equalToConstant: Sizes.userImageSize)
        ])
        userImageView.layer.cornerRadius = Sizes.userImageSize / 2
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = UIColor.systemBlue.cgColor
        userImageView.clipsToBounds = true
    }
    
    private func configureExpandStack() {
        showLabel = UILabel()
        showLabel.text = ExpandedState.showMore.rawValue
        showLabel.textColor = .gray
        chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevronImageView.tintColor = .gray
        
        expandStack = UIStackView(arrangedSubviews: [showLabel, chevronImageView])
        expandStack.axis = .horizontal
        expandStack.alignment = .center
        expandStack.spacing = Paddings.horizontal * 0.3
        
        expandStack.isUserInteractionEnabled = true
        expandStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpandingInfo)))
        expandStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(expandStack)
        NSLayoutConstraint.activate([
//            expandStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.horizontal),
//            expandStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Paddings.horizontal),
            expandStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            expandStack.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 2 * Paddings.vertical)
            expandStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

//MARK: - Nested Types -

extension PersonalInfoCell {
    
    private enum ExpandedState: String {
        case showMore = "Show more"
        case showLess = "Show less"
    }
}

//MARK: - Constants -

extension PersonalInfoCell {
    
    private enum Paddings {
        
        /// 15
        static let horizontal   : CGFloat = 15
        
        /// 10
        static let vertical     : CGFloat = 10
    }
    
    private enum Sizes {
        
        /// 80
        static let userImageSize    : CGFloat = 80
        
        /// 10
        static let chevronImageSize : CGFloat = 10
    }
}
