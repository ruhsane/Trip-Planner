//
//  AddTripViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    var trips: [Trips] = []

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        addTrip()
    }
    
    @IBOutlet weak var tripTextField: UITextField!
    
    func addTrip() {
        if tripTextField.text == "" {
            let alert = UIAlertController(title: "Give this trip a name first!", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            
        }
        
    }
    
    func createNewTrip() -> Item {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Trips", into: store.persistentContainer.viewContext) as! Item
        return newItem
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
