//
//  EstablishmentDetailedViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 16/01/2023.
//

import UIKit

class EstablishmentDetailedViewController : UIViewController {
    var establishment: Establishment!
    
    @IBOutlet weak var establishmentImage: UIImageView!
    
    @IBOutlet weak var ReviewsView: UIView!
    @IBOutlet weak var IncidentsView: UIView!
    
    @IBOutlet weak var benefitsAndLossesButton: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var ratingStars: UIImageView!
    
    @IBOutlet weak var benefitsButton: UIButton!
    @IBOutlet weak var lossesButton: UIButton!
    @IBOutlet weak var locationName: UILabel!
    //Outlets
    
    
    @IBAction func SegmentedControlSelected(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            ReviewsView.isHidden = false
            IncidentsView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            ReviewsView.isHidden = true
            IncidentsView.isHidden = false
        }
        
        
    }
    
    @IBAction func goGraphicsViewCOntroller(_ sender: Any) {

        
        print("Go to Grapgics View")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //
    
    override func viewWillAppear(_ animated: Bool) {
        establishmentImage.image = UIImage(named: "\(establishment.image)")
        locationName.text = "\(establishment.location)"
        ratingStars.image = UIImage(named: "\(establishment.rating)rating")
        benefitsButton.setTitle("  ▲ \(establishment.benefits) $", for: .normal)
        lossesButton.setTitle("  ▼ \(establishment.losses) $", for: .normal)
        
        
        print("\(establishment.benefits)")
        //        nEmployees.text = "\(establishment.nEmployees)"
    }
    
  
    
    
    
    
}



