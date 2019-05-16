//
//  ViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/10/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var trips = [Trips]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
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
    
}
