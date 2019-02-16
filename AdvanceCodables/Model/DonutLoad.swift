//
//  DonutLoad.swift
//  Advance Codable
//
//  Created by Liam Flaherty on 2/15/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import Foundation

struct batter {
    let id : String
    let type : String
    
    enum CodingKeys : String, CodingKey {
        case id
        case type
    }
}

extension batter: Decodable{
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(String.self, forKey: .type)
    }
    
}

extension Donuts: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(String.self, forKey: .type)
        name = try values.decode(String.self, forKey: .name)
        ppu = try values.decode(Float.self, forKey: .ppu)
        do{
            try BestSelling = values.decode(String.self, forKey: .BestSelling)//{
               // BestSelling = try values.decode(String.self, forKey: .BestSelling)
            //}
        }catch{
                BestSelling = "No"
            }

        batters = try values.decode([batter].self, forKey: .batter)
    }
 
}




struct Donuts {
    let id : String
    let type : String
    let name : String
    let ppu : Float
    let batters : [batter]
    var BestSelling : String

    enum CodingKeys : String, CodingKey {
        case id
        case type
        case name
        case ppu
        case batter
        case BestSelling
    }
}

class DonutLoader {
    
    class func donutLoad() -> [Donuts]? {
        var BakedGoods: [Donuts]?

        if let jsonFileUrl = Bundle.main.url(forResource: "Donuts", withExtension: ".json"),
            let jsonData = try? Data(contentsOf: jsonFileUrl) {
            do {
                let decoder = JSONDecoder()
                let donut = try decoder.decode([Donuts].self, from: jsonData)
                print(donut)
                BakedGoods = donut
            } catch let error {
                print(error as? String ?? "Could not provide JSON data for Donuts.json")
            }
        }
        return BakedGoods
        
    }
    
    
    
}

