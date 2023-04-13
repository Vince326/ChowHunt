//
//  RestaurantDetailViewController.swift
//  ChowHunt
//
//  Created by Vincent Hunter on 3/7/23.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel : UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerview:RestaurantDetailViewHeader!
   
    var restaurant: Restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .automatic
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        //Configure the header view
        headerview.nameLabel.text = restaurant.name
        headerview.typeLabel.text = restaurant.type
        headerview.headerImageView.image = UIImage(named: restaurant.image)
        
        let heartImage = restaurant.isFavorite ? "heart.fill" : "heart"
        headerview.heartButton.tintColor = restaurant.isFavorite ? .systemYellow : .white
        headerview.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        
        //Set the properties of the restaurant object for the components
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantTypeLabel.text = restaurant.type
        restaurantNameLabel.text = restaurant.name
        restaurantLocationLabel.text = restaurant.location
       
        navigationItem.backButtonTitle = ""
        
    }
    
    
    //Disables Swipe to hide feature on detail view controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.hidesBarsOnSwipe = false
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "displayMap" {
            // Pass the selected object to the new view controller.
            let destinationController = segue.destination as! MapViewController
            
            destinationController.restaurant = restaurant
        }
        
    }
    
    
}

extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String (describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
            
            cell.descriptionLabel.text = restaurant.description
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoColumnCell.self), for: indexPath) as! RestaurantDetailTwoColumnCell
            
            cell.column1TitleLabel.text = "Address"
            cell.column1TextLabel.text = restaurant.location
            cell.column2TitleLabel.text = "Phone"
            cell.column2TextLabel.text = restaurant.phone
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
            
            cell.configure(location: restaurant.location)
            cell.selectionStyle = .none
            
          return cell
            
        default:
            fatalError("Failed to instantiate the tableView for Detail View Controller")
        }
    }
    
    
}
