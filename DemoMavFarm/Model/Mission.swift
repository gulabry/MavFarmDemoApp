//
//  Mission.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/17/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation

struct Mission: Codable {
    var mission_name: String
    var launch_date_utc: String
    var mission_id: [String]
    var rocket: Rocket
}

extension Mission {
    
    static let launchFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    var launchDate: Date? {
        return Mission.launchFormatter.date(from: launch_date_utc)
    }
    
    var launchDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        guard let launchDate = launchDate
            else { return "N/A" }
        
        return formatter.string(from: launchDate)
    }
    
    //  moves through all the cores and payloads to determain if anything is reused
    //
    var isReusingPieces: Bool {
        return rocket.first_stage.cores.contains { $0.reused == true } ||
            rocket.second_stage.payloads.contains { $0.reused == true }
    }
}
