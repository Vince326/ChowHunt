//
//  RestaurantDetailMapCell.swift
//  ChowHunt
//
//  Created by Vincent Hunter on 4/3/23.
//

import UIKit
import MapKit


class RestaurantDetailMapCell: UITableViewCell {
    
    @IBOutlet var mapView: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
