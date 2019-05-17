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
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        addWaypoint()
    }
    
    @IBAction func TripsBtn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addWaypointButton(_ sender: UIButton) {
        addWaypoint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set trip title
        self.tripTitle.text = mainTrip?.value(forKey: "tripTitle") as? String
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
        
        // fetch from coredata
        let waypointsArr = mainTrip?.waypoints
        allWaypointsInThisTrip = waypointsArr
        
        tableView.reloadData()

        
    }
    
    func addWaypoint() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddWaypointViewController") as? AddWaypointViewController
        viewController?.mainTrip = mainTrip
        self.navigationController!.pushViewController(viewController!, animated: true)
    }
    
}

extension WaypointsViewController: UITableViewDelegate, UITableViewDataSource {
    // waypoint count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTrip?.waypoints?.count ?? 0
    }
    
    // populate waypoints cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleWaypoint = mainTrip?.waypoints?[indexPath.row] as! Waypoints	
        let cell = tableView.dequeueReusableCell(withIdentifier: "waypoint cell", for: indexPath) as! WaypointTableViewCell
        cell.waypointTitle?.text = singleWaypoint.waypointName
        return cell
    }
    
    // delete waypoint
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let singleWaypoint = mainTrip?.waypoints?[indexPath.row] as? Waypoints
        if editingStyle == .delete {
            ManageTrip.managedContext.delete(singleWaypoint!)
            ManageTrip.saveTrip()
            tableView.reloadData()
        }
    }
    
    // show detail for waypoint on select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let displayWaypointVC = storyboard.instantiateViewController(withIdentifier: "DetailWaypointViewController") as! DetailWaypointViewController
        displayWaypointVC.title = mainTrip?.value(forKey: "tripTitle") as? String
        let singleWaypoint = mainTrip?.waypoints?[indexPath.row] as? Waypoints
        displayWaypointVC.lat = singleWaypoint?.lat
        displayWaypointVC.lng = singleWaypoint?.long
        displayWaypointVC.name = singleWaypoint?.waypointName
        self.navigationController?.pushViewController(displayWaypointVC, animated: true)
    }
    
}
