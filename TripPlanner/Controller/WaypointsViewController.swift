//
//  WaypointsViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class WaypointsViewController: UIViewController {

    var currentTrip: Trips?
    var allWaypointsInThisTrip: NSMutableOrderedSet?
    

    @IBOutlet weak var tripTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set trip title
        self.tripTitle.text = currentTrip?.value(forKey: "tripTitle") as? String
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    @IBAction func TripsBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        tableView.reloadData()
        
        // fetch from coredata
        let waypointsArr = currentTrip?.waypoints
        allWaypointsInThisTrip = waypointsArr
    }
    
}

extension WaypointsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTrip?.waypoints?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleWaypoint = currentTrip?.waypoints?[indexPath.row] as? Waypoints
        let cell = tableView.dequeueReusableCell(withIdentifier: "waypoint cell", for: indexPath) as! WaypointTableViewCell
        cell.waypointTitle?.text = singleWaypoint?.waypointName
        return cell
    }
    
}
