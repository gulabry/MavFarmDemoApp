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
        static let launchCell = "launchCell"
    }

    private lazy var stackView: UIStackView = configureSubview(UIStackView(arrangedSubviews: [missionNameLabel, missionTimeLabel, missionIDLabel, rocketNameLabel, reusePiecesLabel])) {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    lazy var missionNameLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    lazy var missionTimeLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var missionIDLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
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
        
        backgroundColor = .black
        stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Constants.padding).activate()
        stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: Constants.padding).activate()
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.padding).activate()
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding).activate()
    }
    
    func configure(with mission: Mission) {
        missionNameLabel.text = "\(mission.mission_name)"
        missionIDLabel.text = "Mission ID: \(mission.mission_id.first ?? "N/A")"
        missionTimeLabel.text = "Launch Date:\(mission.launchDateString)"
        reusePiecesLabel.text = "Reused Pieces: \(mission.isReusingPieces)"
        rocketNameLabel.text = "Rocket: \(mission.rocket.rocket_name)"
    }
}
