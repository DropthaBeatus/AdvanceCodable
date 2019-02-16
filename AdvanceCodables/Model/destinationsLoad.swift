//
//  destinationsLoad.swift
//  Advance Codable
//
//  Created by Liam Flaherty on 2/15/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import Foundation

//2016/10/08 22:31

struct StartT {
    
    let DateTime : Date
    let TimeZone : String
    
    enum Coding: String, CodingKey {
        case DateTime
        case TimeZone
    }
}

extension StartT: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Coding.self)
        let timeString = try values.decode(String.self, forKey: .DateTime)
        TimeZone = try values.decode(String.self, forKey: .TimeZone)
        DateTime = dateConv(dateString: timeString)!
    }
    
}

struct EndT {
    let DateTime : Date
    let TimeZone : String
    
    enum Coding: String, CodingKey {
        case DateTime
        case TimeZone
    }
}

extension EndT: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Coding.self)
        let timeString = try values.decode(String.self, forKey: .DateTime)
        TimeZone = try values.decode(String.self, forKey: .TimeZone)
        DateTime = dateConv(dateString: timeString)!
        
    }
    
}

struct BodyT {
    
    let ContentType : String
    let Content : String
    
    enum CodingKeys: String, CodingKey {
        case ContentType
        case Content
    }
}

extension BodyT: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ContentType = try values.decode(String.self, forKey: .ContentType)
        Content = try values.decode(String.self, forKey: .Content)
    }
    
}


extension Destinations: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
            Subject = try values.decode(String.self, forKey: .Subject)
            start = try values.decode(StartT.self, forKey: .Start)
            end = try values.decode(EndT.self, forKey: .End)
            body = try values.decode(BodyT.self, forKey: .Body)

    }
    
}

struct Destinations {

    let Subject : String
    let body : BodyT
    let start : StartT
    var end : EndT
    
    enum CodingKeys: String, CodingKey {
        case Subject
        case Body
        case Start
        case End
    }
}

//need to do a better throw here for different date types like if its UTC or something else
func dateConv(dateString: String)->Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    let date = dateFormatter.date(from: dateString)
    return date
    
}





class DestLoader {
    
    class func destinationLoad() -> [Destinations]? {
        var vacations: [Destinations] = []

        if let jsonFileUrl = Bundle.main.url(forResource: "destinations", withExtension: ".json"),
            let jsonData = try? Data(contentsOf: jsonFileUrl) {
            do {
                let decoder = JSONDecoder()
                let destination = try decoder.decode([Destinations].self, from: jsonData)
                print(destination)
                vacations = destination
                return vacations
            } catch let error {
                print(error as? String ?? "Could not provide JSON data for destinations.json")
            }
        }
        

        
        return vacations
    }
 
    
    
}
