//
//  RestaurantDiffableDataSource.swift
//  ChowHunt
//
//  Created by Vincent Hunter on 2/27/23.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

}
