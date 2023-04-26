//
//  ReviewViewController.swift
//  ChowHunt
//
//  Created by Vincent Hunter on 4/13/23.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet var closeButton: UIButton!
    
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: restaurant.image)
        
        // Do any additional setup after loading the view.
        
        //Applies Blur Effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform
        )
        let moveOutTransform = CGAffineTransform.init(translationX: 0, y: -600)
        
        // Make the button invisible and move off the screen
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
        
        closeButton.transform = moveOutTransform
        
    }
    
    override func viewWillAppear (_ animated: Bool) {
        
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.3, options: [], animations: {
            self.rateButtons[0].alpha = 1.0
            self.rateButtons[0].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations
                       : {
            self.rateButtons[1].alpha = 1.0
            // For loop attempt at animating buttons and changing alpha levels
            for index in 0...4 {
                UIView.animate(withDuration: 0.4, delay: (0.1 + 0.5 * Double(index)), options: [], animations: {
                    self.rateButtons[index].alpha = 1.0
                    self.rateButtons[index].transform = .identity
                },completion: nil)
            }
            UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
                self.closeButton.transform = .identity
            }, completion: nil)
            
        }
                
    )}

        }
