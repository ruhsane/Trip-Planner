//
//  AddWaypointViewController.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.

import UIKit
import MapKit
import GooglePlaces
import CoreData

class AddWaypointViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var mainTrip: Trips?

    var placeName: String = ""
    var waypointLat: Double = 0
    var waypointLong: Double = 0
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        if mapView.annotations.count == 0 {
            // if no annotation selected, raise alert view
            let alert = UIAlertController(title: "Select a location first!", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            saveWaypoint()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    func saveWaypoint() {
        // new waypoint entity
        let waypoint = Waypoints(context: ManageTrip.managedContext)
        waypoint.waypointName = placeName
        waypoint.lat = waypointLat
        waypoint.long = waypointLong
        
        // add to trip waypoints set
        mainTrip?.addToWaypoints(waypoint)
        ManageTrip.saveTrip()

        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WaypointsViewController") as? WaypointsViewController
//        viewController!.title = trips[indexPath.row].tripTitle
        self.navigationController!.pushViewController(viewController!, animated: true)

    }
    
    private func setupSearchBar() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 0, width: 350.0, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        mapView.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        self.navigationController?.isNavigationBarHidden = true;

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // This makes the view area include the nav bar even though it is opaque.
        // Adjust the view placement down.
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
    }
    
}

// Handle the user's selection.
extension AddWaypointViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        
        searchController?.isActive = false
        
        placeName = place.name!
        waypointLat = place.coordinate.latitude
        waypointLong = place.coordinate.longitude

        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10)
        let region = MKCoordinateRegion(center: place.coordinate, span: mapSpan)

        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        annotation.subtitle = place.formattedAddress
        mapView.addAnnotation(annotation)
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
