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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTrip?.waypoints?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleWaypoint = mainTrip?.waypoints?[indexPath.row] as! Waypoints	
        let cell = tableView.dequeueReusableCell(withIdentifier: "waypoint cell", for: indexPath) as! WaypointTableViewCell
        cell.waypointTitle?.text = singleWaypoint.waypointName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let singleWaypoint = mainTrip?.waypoints?[indexPath.row] as? Waypoints
        if editingStyle == .delete {
            ManageTrip.managedContext.delete(singleWaypoint!)
            ManageTrip.saveTrip()
            tableView.reloadData()
        }
    }
    
}
