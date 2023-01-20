//
//  PostCell.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 05.01.2023.
//

import UIKit

final class RMCharacterCell: UITableViewCell {
    
    //MARK: - Identifier -
    
    static let identifier = String(describing: RMCharacterCell.self)
    
    //MARK: - UI Elements -
    
    private var characterImageView  : UIImageView!
    private var nameLabel           : UILabel!
    private var statusImageView     : UIImageView!
    private var statusLabel         : UILabel!
    private var statusStackView     : UIStackView!
    private var locationTitleLabel  : UILabel!
    private var locationLabel       : UILabel!
    private var firstSeenTitleLabel : UILabel!
    private var firstSeenLabel      : UILabel!
    
    //MARK: - Initialisation -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImageView()
        configureNameLabel()
        configureStatusStackView()
        selectionStyle = .default
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Internal Functions -

extension RMCharacterCell {
    
    func setCharacter(_ character: RMCharacter) {
        downloadImage(fromUrl: character.imageUrl)
        nameLabel.text = character.name
        statusImageView.tintColor = getColor(forStatus: character.status)
        statusLabel.text = character.status.rawValue + " - " + character.species
    }
}

//MARK: - Private Helpers -

extension RMCharacterCell {
    private func downloadImage(fromUrl url: String) {
        guard let url = URL(string: url) else { return }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: data!)
            }
        }
    }
    
    private func getColor(forStatus status: RMStatus) -> UIColor {
        switch status {
        case .alive:
            return .systemGreen
        case .dead:
            return .systemRed
        case .unknown:
            return .systemGray
        }
    }
}

//MARK: - UI Configuration -

extension RMCharacterCell {
    private func configureImageView() {
        characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: Sizes.imageViewSize)
        ])
    }
    
    private func configureNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = .boldSystemFont(ofSize: 23)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: Paddings.top),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.leadings),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Paddings.trailing)
        ])
    }
    
    private func configureStatusStackView() {
        statusImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusImageView.widthAnchor.constraint(equalToConstant: Sizes.statusImageSize),
            statusImageView.heightAnchor.constraint(equalToConstant: Sizes.statusImageSize)
        ])
        statusLabel = UILabel()
        statusStackView = UIStackView(arrangedSubviews: [statusImageView, statusLabel])
        statusStackView.axis = .horizontal
        statusStackView.alignment = .center
        statusStackView.spacing = 8
        statusStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statusStackView)
        NSLayoutConstraint.activate([
            statusStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Paddings.leadings),
            statusStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Paddings.top),
            statusStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Paddings.trailing)
        ])
    }
}

//MARK: - Constants -

extension RMCharacterCell {
    private enum Paddings {
        
        /// 15
        static let leadings : CGFloat = 15
        
        /// 15
        static let trailing : CGFloat = 15
        
        /// 15
        static let top      : CGFloat = 15
    }
    
    private enum Sizes {
        
        /// 150
        static let imageViewSize    : CGFloat = 270
        
        static let statusImageSize  : CGFloat = 20
    }
}
