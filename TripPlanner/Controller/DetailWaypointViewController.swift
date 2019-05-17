//
//  DetailWaypointViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/16/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit
import MapKit

class DetailWaypointViewController: UIViewController {

    var lat: Double?
    var lng: Double?
    var name: String?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set region
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lng!), span: span)
        mapView.setRegion(region, animated: true)
        
        // set the pin on map
        let annotation = MKPointAnnotation()
        if let lat = lat, let lng = lng {
            annotation.coordinate.latitude = lat
            annotation.coordinate.longitude = lng
            annotation.title = self.name
        }
        
        mapView.addAnnotation(annotation)
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
