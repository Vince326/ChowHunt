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
        switch segue.identifier {
        case "displayMap":
            // Pass the selected object to the MapViewcontroller.
            let destinationController = segue.destination as! MapViewController
            
            destinationController.restaurant = restaurant
            
        case "showReview":
            //Navigates the object to reviewViewController
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
            
        default: break
        }
        
    }
    
    @IBAction func close (segue: UIStoryboardSegue) {
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }
        
        dismiss(animated: true,completion: {
            
            if let rating = Restaurant.Rating(rawValue: identifier) {
                self.restaurant.rating = rating
                self.headerview.ratingImageView.image = UIImage(named: rating.image)
            }
            
            let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.headerview.ratingImageView.transform = scaleTransform
            self.headerview.ratingImageView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3,initialSpringVelocity: 0.7, options: [], animations: {
                self.headerview.ratingImageView.transform = .identity
                self.headerview.ratingImageView.alpha = 1
            }, completion: nil)
            
        })
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
