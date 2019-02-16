//
//  AdvanceCodableViewController.swift
//  AdvanceCodables
//
//  Created by Liam Flaherty on 2/15/19.
//  Copyright © 2019 Liam Flaherty. All rights reserved.
//

import UIKit

class AdvanceCodableViewController: UIViewController {
    //Easy to grade explanation:
    
    //File destinationsLoad.swift useses manual date decoding for RFC time
    
    //File DonutLoad.swift useses manually decoding for imperfect data as in Donuts.json "BestSelling" does not allways exsist! I gave BestSelling a default value if it did not exsist
    
    //File royaltyLoad.swift useses simple manually decoding as to build understanding
    
    @IBOutlet weak var textDisplay: UITextView!
    
    var royaltyJSON : [royals]? = []
    var donutsJSON : [Donuts]? = []
    var destinationJSON : [Destinations]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //I know this is bad practice as this will waste memory space if actually implemented
        //each json file should be loaded on its own
        donutsJSON = DonutLoader.donutLoad()
        destinationJSON = DestLoader.destinationLoad()
        royaltyJSON = RoyalLoader.royalLoad()
    }
    
    @IBAction func loadDonutJsonBTN(_ sender: Any) {
        var displayJSON = ""
        for donut in donutsJSON!{
            displayJSON += "ID: \(donut.id)\n"
            displayJSON += "\(donut.name)\n"
            displayJSON += "Price Per Unit: $\(donut.ppu)\n"
            displayJSON += "DONUT BATTER TYPES:\n"
            for batter in donut.batters{
                displayJSON += "\tID: \(batter.id)\n"
                displayJSON += "\tType: \(batter.type)\n"
                displayJSON += "\n"
            }
            
            displayJSON += "Is this a best seller? --> \(donut.BestSelling)\n"
            displayJSON += "\n"
        }
        
        textDisplay.text = displayJSON
        
    }
    
    @IBAction func loadRoyaltyJsonBTN(_ sender: Any) {
        var displayJSON = ""
        for monarch in royaltyJSON!{
            displayJSON += "ID: \(monarch.id)\n"
            displayJSON += "Name: \(monarch.name)\n"
            displayJSON += "House: \(monarch.house)\n"
            displayJSON += "Years: \(monarch.years)\n"
            displayJSON += "City: \(monarch.city)\n"
            displayJSON += "\n"
        }
        textDisplay.text = displayJSON
    }
    
    @IBAction func loadDestinationJsonBTN(_ sender: Any) {
        var displayJSON = ""
        for destination in destinationJSON!{
            displayJSON += "Subject: \(destination.Subject)\n"
            displayJSON += "Content Type : \(destination.body.ContentType)\n"
            displayJSON += "Content: \(destination.body.Content)\n"
            displayJSON += "Start Date: \(destination.start.DateTime)\n"
            displayJSON += "End Date: \(destination.end.DateTime)\n"
            displayJSON += "\n"
        }
        
        textDisplay.text = displayJSON
    }
    
    
}
