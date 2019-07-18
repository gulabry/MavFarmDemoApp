//
//  ViewCoordinator.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/18/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation

class MissionCoordinator {
    
    var missions = [Mission]()
    var nextMission: Mission?
    
    var timer = Timer()
    
    var missionController: MissionViewController!
    
    init(with controller: MissionViewController) {
        self.missionController = controller
    }
    
    func setup() {
        
        missionController.view.backgroundColor = .black
        missionController.missionView.topLabel.text = "Countdown Until Next Launch"
        missionController.missionView.timerLabel.text = "0h 0m 0s"
        
        missionController.missionView.stackView.backgroundColor = .clear
        missionController.missionView.tableView.backgroundColor = .clear
        
        missionController.missionView.tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.Constants.launchCell)
        missionController.missionView.tableView.rowHeight = 150
        missionController.missionView.tableView.dataSource = missionController
        missionController.missionView.tableView.delegate = missionController

        
        Network.get(mission: .upcoming) { missions in
            DispatchQueue.main.async {
                self.missions = missions
                self.missionController.missionView.tableView.reloadData()
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
    
    func numberOfRowsInSection() -> Int {
        return missions.count
    }
    
    func configure(cell: LaunchTableViewCell, indexPath: IndexPath) -> LaunchTableViewCell {
        cell.configure(with: missions[indexPath.row])
        return cell
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MissionCoordinator.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        guard let mission = nextMission, let launchDate = mission.launchDate else { return }
        DispatchQueue.main.async {
            self.missionController.missionView.timerLabel.text = self.timeString(time: launchDate.timeIntervalSince1970 - Date().timeIntervalSince1970)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02ih %02im %02is", hours, minutes, seconds)
    }
}
