//
//  NoWaypointsViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class NoWaypointsViewController: UIViewController {
    
    var mainTrip: Trips?
    
    @IBAction func addWaypointBtn(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddWaypointViewController") as? AddWaypointViewController
        viewController?.mainTrip = mainTrip
        self.navigationController!.pushViewController(viewController!, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
