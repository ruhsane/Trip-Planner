//
//  Waypoints+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//
//

import Foundation
import CoreData


extension Waypoints {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Waypoints> {
        return NSFetchRequest<Waypoints>(entityName: "Waypoints")
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var waypointName: String?
    @NSManaged public var trip: Trips?

}
