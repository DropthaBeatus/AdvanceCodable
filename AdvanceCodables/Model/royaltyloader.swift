//
//  royaltyloader.swift
//  Advance Codable
//
//  Created by Liam Flaherty on 2/15/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import Foundation

struct royals {
    let id : Int
    let name : String
    let city : String
    let house : String
    let years : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nm
        case cty
        case hse
        case yrs
    }
    
}

//first time manually decode will start slow then work way up
extension royals: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .nm)
        city = try values.decode(String.self, forKey: .cty)
        house = try values.decode(String.self, forKey: .hse)
        years = try values.decode(String.self, forKey: .yrs)
    }
    
}

class RoyalLoader {
    
    class func royalLoad() -> [royals]? {
        var monarchs : [royals]?
        
        if let jsonFileUrl = Bundle.main.url(forResource: "royalty", withExtension: ".json"),
            let jsonData = try? Data(contentsOf: jsonFileUrl) {
            do {
                let decoder = JSONDecoder()
                let rulers = try decoder.decode([royals].self, from: jsonData)
                print(rulers)
                monarchs = rulers
            } catch let error {
                print(error as? String ?? "Could not provide JSON data for royalty.json")
            }
        }
        return monarchs
    }
}
