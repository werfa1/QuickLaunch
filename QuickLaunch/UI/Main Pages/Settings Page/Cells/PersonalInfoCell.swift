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
    
    //MARK: - Initialisation -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI Configuration -

extension PersonalInfoCell {
    
    private func configureUserImageView() {
        userImageView = UIImageView(image: UIImage(systemName: "person-fill"))
        
    }
}
