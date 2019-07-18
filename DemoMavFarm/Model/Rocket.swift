//
//  Rocket.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/18/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation

struct Rocket: Codable {
    var rocket_name: String
    var first_stage: FirstStage
    var second_stage: SecondStage
}
