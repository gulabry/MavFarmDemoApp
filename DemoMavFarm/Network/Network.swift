//
//  Network.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/17/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
}

enum MissionType {
    case upcoming
    case next
}

struct Network {
    
    static func get(mission type: MissionType, completion: @escaping ([Mission]) -> Void) {
        
        var urlString: String
        switch type {
        case .next:
            urlString = "https://api.spacexdata.com/v3/launches/next"
        case .upcoming:
            urlString = "https://api.spacexdata.com/v3/launches/upcoming"
        }
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            guard let d = data else { return completion([Mission]()) }
            
            do {
                switch type {
                case .next:
                    let nextMission = try JSONDecoder().decode(Mission.self, from: d)
                    completion([nextMission])
                case .upcoming:
                    let missions = try JSONDecoder().decode([Mission].self, from: d)
                    completion(missions)
                }
                
            } catch let error {
                print(error.localizedDescription)
                completion([Mission]())
            }
        })
        task.resume()
    }
}
