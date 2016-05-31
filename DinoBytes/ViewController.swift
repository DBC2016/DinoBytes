//
//  ViewController.swift
//  DinoBytes
//
//  Created by Demond Childers on 5/24/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var dinoTitleLabel               :UILabel!
    @IBOutlet private weak var dinoDescripLabelTextView     :UITextView!
    @IBOutlet private weak var dinoImageView                :UIImageView!
    @IBOutlet private weak var dinoHeightLabel              :UILabel!
    @IBOutlet private weak var dinoWeightLabel              :UILabel!
    @IBOutlet private weak var dinoDietLabel                :UILabel!
    
    
//    var filteredArray1 = ["Velociraptor","Lipoleurdon","Stegosaurus"]
    
    
    
    let backendless = Backendless.sharedInstance()
    var dinosArray = [Dinosaurs]()
    var selectedBeacon  :String!
    var selectedDinosaur :Dinosaurs?
    
    
    
    //Save Function
    
    func saveDino(dino: Dinosaurs){
        let dataStore = backendless.data.of(Dinosaurs.ofClass())
        dataStore.save(dino, response: { (response) in
            print("Dino saved \(dino.dinoName)")
        }) { (error) in
            print("Dino \(dino.dinoName) not saved, error \(error)")
            
        

            
        }
        
    }
    
    
    func tempAddRecords() {
        print("TAR")
        
//        let dino1 = Dinosaurs()
//        dino1.dinoName = "Velociraptor /vᵻˈlɒsᵻræptər/"
//        dino1.dinoHeight = "2 ft"
//        dino1.dinoWeight = "45 lbs"
//        dino1.dinoDiet = "Carnivore"
//        dino1.dinoImage = "raptorImage"
//        dino1.dinoBeacon = "raptorBeacon"
//        dino1.dinoDescrip = "The velociraptor was a speedy meat eating dinosaur that could run at high speeds and jump good distances. The velociraptor lived in the crustaceous period, and tended to live in hotter climates. Unlike popular culture tells us, the velociraptor was covered mostly in feathers, not scales."
//        saveDino(dino1)
        
    
    
    
//        let dino2 = Dinosaurs()
//        dino2.dinoName = "Stegosaurus (/ˌstɛɡəˈsɔːrəs/)"
//        dino2.dinoHeight = "30ft (length)"
//        dino2.dinoWeight = "5 tons"
//        dino2.dinoDiet = "Ferns and cycads"
//        dino2.dinoImage = "stegoImage"
//        dino2.dinoBeacon = "stegoBeacon"
//        dino2.dinoDescrip = "Stegosaurus is one of the most elaborately-ornamented dinosaurs.  This herbivore is decked with 17 bony plates from its neck down its back, with the tip of its tail bearing four long spikes. When threatened, Stegosaurus will turn its head back to look over its shoulder, to better aim the swing of its dangerous tail."
//    
//        saveDino(dino2)
        
    
    
        let dino3 = Dinosaurs()
        dino3.dinoName = "Lipoleurdon /ˌlaɪoʊˈplʊərədɒn/"
        dino3.dinoHeight = "23 to 38 feet (length)"
        dino3.dinoWeight = "150 tons"
        dino3.dinoDiet = "Carnivore"
        dino3.dinoImage = "lipoImage"
        dino3.dinoBeacon = "lipoBeacon"
        dino3.dinoDescrip = "This carnivorous marine reptile belonging to the Pilosauroidea, a clade of short-necked plesiosaurs, it made T.rex look like a kitten. The two species of Liopleurodon lived during the Callovian stage of the Middle Jurassic Period. It was the apex predator of the Middle to Late Jurassic seas that covered Europe."
        
        saveDino(dino3)
        
    }
    

    //MARK: - Fetch Methods
    
    func fetchDinosaurs() {
        let dataQuery = BackendlessDataQuery()
//        let whereClause = "dinoBeacon = '\(selectedBeacon)'"
//        dataQuery.whereClause = whereClause
        
        
        var error: Fault?
        let bc = backendless.data.of(Dinosaurs.ofClass()).find(dataQuery, fault:  &error)
        if error == nil {
            dinosArray = bc.getCurrentPage() as! [Dinosaurs]
            print("Found \(dinosArray.count)")
            
            
            //load dinosaur info
        
            } else {
            print("Find Error \(error)")

        
        }
        
    }
    
    
    //MARK: - LIFE CYCLE METHODS

    func beaconInRange(notifcation: NSNotification) {
        if let region = notifcation.userInfo?["region"] {
            print("Found: \(region)")
            let filteredArray = dinosArray.filter {$0.dinoBeacon == region as! String}
            let foundDino = filteredArray[0]
            print("Selected \(foundDino.dinoName)")
            dinoTitleLabel.text = foundDino.dinoName
            dinoDescripLabelTextView.text = foundDino.dinoDescrip
            dinoHeightLabel.text = foundDino.dinoHeight
            dinoWeightLabel.text = foundDino.dinoWeight
            dinoDietLabel.text = foundDino.dinoDiet 
//            dinoImageView.image = 
            
            
            

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tempAddRecords()


        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(beaconInRange), name: "inRange", object: nil)
        fetchDinosaurs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

