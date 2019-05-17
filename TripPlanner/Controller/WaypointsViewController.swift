//
//  WaypointsViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class WaypointsViewController: UIViewController {

    var mainTrip: Trips?
    var allWaypointsInThisTrip: NSMutableOrderedSet?
    

    @IBOutlet weak var tripTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set trip title
        self.tripTitle.text = mainTrip?.value(forKey: "tripTitle") as? String
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    @IBAction func TripsBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
        tableView.reloadData()
        
        // fetch from coredata
        let waypointsArr = mainTrip?.waypoints
        allWaypointsInThisTrip = waypointsArr
        
        
    }
    
}

extension WaypointsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTrip?.waypoints?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleWaypoint = mainTrip?.waypoints?[indexPath.row] as! Waypoints	
        let cell = tableView.dequeueReusableCell(withIdentifier: "waypoint cell", for: indexPath) as! WaypointTableViewCell
        cell.waypointTitle?.text = singleWaypoint.waypointName
        return cell
    }
    
}
