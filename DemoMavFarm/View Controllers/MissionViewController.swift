//
//  ViewController.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/17/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit

class MissionViewController: UIViewController {
    
    lazy var missionView: MissionView = view.configureSubview(MissionView()) {
        $0.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).activate()
        $0.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor).activate()
        $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).activate()
        $0.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).activate()
    }
    
    lazy var coordinator = MissionCoordinator(with: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.setup()
    }
}

extension MissionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator.missions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.Constants.launchCell, for: indexPath) as? LaunchTableViewCell else { fatalError("Launch Table View Cell cannot be created.")}
        
        cell.configure(with: coordinator.missions[indexPath.row])
        
        return cell
    }
}
