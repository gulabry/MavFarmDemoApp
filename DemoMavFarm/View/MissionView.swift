//
//  MissionView.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/18/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation
import UIKit

class MissionView: UIView {
    
    struct Constants {
        static let padding: CGFloat = 15.0
        static let stackViewHeight: CGFloat = 80.0
        static let topTableViewPadding: CGFloat = 30.0
    }
    
    lazy var stackView: UIStackView = configureSubview(UIStackView(arrangedSubviews: [self.topLabel, self.timerLabel])) {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).activate()
        $0.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight).activate()
        $0.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.padding).activate()
        $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).activate()
    }
    
    lazy var timerLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    lazy var topLabel: UILabel = configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var tableView: UITableView = configureSubview(UITableView()) {
        $0.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).activate()
        $0.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).activate()
        $0.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).activate()
        $0.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).activate()
        $0.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: Constants.topTableViewPadding).activate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        tableView.separatorStyle = .none
    }
}
