//
//  LaunchTableViewCell.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/17/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    
    struct Constants {
        static let padding: CGFloat = 8
    }

    private lazy var stackView: UIStackView = configureSubview(UIStackView(arrangedSubviews: [missionNameLabel, missionTimeLabel, missionIDLabel, rocketNameLabel, reusePiecesLabel])) {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    lazy var missionNameLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    lazy var missionTimeLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var missionIDLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    lazy var rocketNameLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var reusePiecesLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        backgroundColor = .red
        stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Constants.padding).activate()
        stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: Constants.padding).activate()
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.padding).activate()
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding).activate()
        
//        Name: "CRS-18"
//        Time: 2019-07-21T23:35:00.000Z
//        ID: EE86F74
//        Rocket: Falcon 9
//        Reused Pieces: Yes
        
        missionNameLabel.text = "Name: CRS-18"
        missionIDLabel.text = "Mission ID: EE86F74"
        missionTimeLabel.text = "Launch Date: 2019-07-21T23:35:00.000Z"
        reusePiecesLabel.text = "Reused Pieces: Yes"
        rocketNameLabel.text = "Rocket: Falcon 9"
        
    }
    
    func configure(with: Int) {
        
    }
}
