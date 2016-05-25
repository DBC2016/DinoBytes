//
//  ViewController.swift
//  DinoBytes
//
//  Created by Demond Childers on 5/24/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func beaconInRange(notifcation: NSNotification) {
        if let region = notifcation.userInfo?["region"] {
            print("Found: \(region)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconInRange), name: "inRange", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

