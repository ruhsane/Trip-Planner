//
//  AddTripViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit
import CoreData

class AddTripViewController: UIViewController {

    var trips: [Trips] = []
    

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        addTrip()
    }
    
    @IBOutlet weak var tripTextField: UITextField!
    
    func addTrip() {
        // if trip name is empty, raise alert view
        if tripTextField.text == "" {
            let alert = UIAlertController(title: "Give this trip a name first!", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        // we have trip name
        } else {
            
            // Save trip to coredata
            let trip = ManageTrip.addTrip()
            trip.tripTitle = tripTextField.text
            ManageTrip.saveTrip()
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
