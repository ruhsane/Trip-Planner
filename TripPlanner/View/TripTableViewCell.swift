//
//  TripTableViewCell.swift
//  TripPlanner
//
//  Created by Ruhsane Sawut on 5/10/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var tripTitle: UILabel!
    
//    func configure(_ trip: Trip) {
//        tripTitle.text = trip.tripTitle
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
