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
    }
    
    private var missions = [Mission]()
    private var nextMission: Mission?
    
    var timer = Timer()
    var isTimerRunning = false
    
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
        timerLabel.text = "0h 0m 0s"
        stackView.backgroundColor = .clear
        tableView.backgroundColor = .clear
        
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.Constants.launchCell)
        tableView.rowHeight = 130
        tableView.dataSource = self

        Network.get(mission: .upcoming) { missions in
            DispatchQueue.main.async {
                self.missions = missions
                self.tableView.reloadData()
            }
        }
        
        Network.get(mission: .next) { mission in
            DispatchQueue.main.async {
                self.nextMission = mission.first
                self.timer.invalidate()
                self.runTimer()
            }
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        guard let mission = nextMission, let launchDate = mission.launchDate else { return }
        timerLabel.text = timeString(time: launchDate.timeIntervalSince1970 - Date().timeIntervalSince1970)
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02ih %02im %02is", hours, minutes, seconds)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.Constants.launchCell, for: indexPath) as? LaunchTableViewCell else { fatalError("Launch Table View Cell cannot be created.")}
        
        cell.configure(with: missions[indexPath.row])
        
        return cell
    }
}

