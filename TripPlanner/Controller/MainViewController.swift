//
//  ViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/10/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var trips = [Trips]() {
        didSet{
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trips = ManageTrip.getTrips()
        self.navigationController?.isNavigationBarHidden = false
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trip cell", for: indexPath) as! TripTableViewCell
        cell.tripTitle.text = trips[indexPath.row].tripTitle
        
        return cell
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            print(self.trips)
            // remove the item from the data model
            let selectedTrip = self.trips[indexPath.row]
            trips.remove(at: indexPath.row)
            ManageTrip.deleteTrip(trip: selectedTrip)
            
            // reload table view after deletion
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if trips[indexPath.row].waypoints?.count == 0 {
            
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoWaypointsViewController") as! NoWaypointsViewController
            viewController.mainTrip = trips[indexPath.row]
            viewController.title = trips[indexPath.row].tripTitle
            self.navigationController!.pushViewController(viewController, animated: true)
            
            
        } else {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WaypointsViewController") as? WaypointsViewController
            viewController!.title = trips[indexPath.row].tripTitle
            self.navigationController!.pushViewController(viewController!, animated: true)
            
        }
    }
    
}
