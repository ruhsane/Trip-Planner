//
//  Trips+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/15/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//
//

import Foundation
import CoreData


extension Trips {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trips> {
        return NSFetchRequest<Trips>(entityName: "Trips")
    }

    @NSManaged public var tripTitle: String?
    @NSManaged public var waypoints: NSMutableOrderedSet?

}

// MARK: Generated accessors for waypoints
extension Trips {

    @objc(addWaypointsObject:)
    @NSManaged public func addToWaypoints(_ value: Waypoints)

    @objc(removeWaypointsObject:)
    @NSManaged public func removeFromWaypoints(_ value: Waypoints)

    @objc(addWaypoints:)
    @NSManaged public func addToWaypoints(_ values: NSSet)

    @objc(removeWaypoints:)
    @NSManaged public func removeFromWaypoints(_ values: NSSet)

}
