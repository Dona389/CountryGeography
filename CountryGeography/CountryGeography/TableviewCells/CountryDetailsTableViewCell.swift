//
//  CountryDetailsTableViewCell.swift
//  CountryGeography
//
//  Created by Dona Thomas on 15/07/20.
//  Copyright © 2020 Dona Thomas. All rights reserved.
//

import UIKit

class CountryDetailsTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    // MARK: Setup the tableviewcell components
    let nameLabel = UILabel()
    let detailLabel = UILabel()
    let profileImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        self.contentView.backgroundColor = UIColor.lightText
        // configure imageview
        setupImageView()
        // configure titleLabel
        setupTitleLabel(marginGuide: marginGuide)
        // configure authorLabel
        setupDetailLabel(marginGuide: marginGuide)
    }
    func setupImageView() {
        profileImgView.isAccessibilityElement = true
        profileImgView.accessibilityIdentifier = StringUtil.cellImageviewAccessibilityId.rawValue
        self.contentView.addSubview(profileImgView)
        profileImgView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupTitleLabel(marginGuide: UILayoutGuide) {
        nameLabel.isAccessibilityElement = true
        nameLabel.accessibilityIdentifier = StringUtil.cellNameLabelAccessibilityId.rawValue
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.profileImgView.trailingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: StringUtil.boldFont.rawValue, size: 16)
    }
    func setupDetailLabel(marginGuide: UILayoutGuide) {
        detailLabel.isAccessibilityElement = true
        detailLabel.accessibilityIdentifier = StringUtil.countryDetailsCellReuseIdentifier.rawValue
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: self.profileImgView.trailingAnchor, constant: 20).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont(name: StringUtil.regularFont.rawValue, size: 13)
        detailLabel.textColor = UIColor.darkGray
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
