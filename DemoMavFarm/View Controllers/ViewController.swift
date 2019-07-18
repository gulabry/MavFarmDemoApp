//
//  ViewController.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/17/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let padding: CGFloat = 15.0
        static let stackViewHeight: CGFloat = 80.0
        static let topTableViewPadding: CGFloat = 30.0
        
        static let launchCell = "launchCell"
    }
    
    private lazy var stackView: UIStackView = view.configureSubview(UIStackView(arrangedSubviews: [self.topLabel, self.timerLabel])) {
        guard let view = self.view else { return }
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).activate()
        $0.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight).activate()
        $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding).activate()
        $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
    }
    
    lazy var timerLabel: UILabel = view.configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    lazy var topLabel: UILabel = view.configureSubview(UILabel()) {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var tableView: UITableView = view.configureSubview(UITableView()) {
        guard let view = self.view else { return }
        $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).activate()
        $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).activate()
        $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).activate()
        $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).activate()
        $0.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: Constants.topTableViewPadding).activate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        topLabel.text = "Countdown Until Next Launch"
        timerLabel.text = "00:00"
        stackView.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: Constants.launchCell)
        tableView.rowHeight = 120
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.launchCell, for: indexPath) as? LaunchTableViewCell else { fatalError("Launch Table View Cell cannot be created.")}
        
        cell.configure(with: 1)
        
        return cell
    }
}

