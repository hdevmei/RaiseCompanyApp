//
//  EstablishmentDetailedViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 16/01/2023.
//

import UIKit

class EstablishmentDetailedViewController : UIViewController {
    @IBOutlet weak var nEmployees: UILabel!
    var establishment: Establishment!
    
    @IBOutlet weak var establishmentImage: UIImageView!
    
    
    @IBOutlet weak var ratingStars: UIImageView!
    
    @IBOutlet weak var locationName: UILabel!
    //Outlets
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //
    
    override func viewWillAppear(_ animated: Bool) {
        establishmentImage.image = UIImage(named: "\(establishment.image)")
        locationName.text = "\(establishment.location)"
        ratingStars.image = UIImage(named: "\(establishment.rating)rating")
//        nEmployees.text = "\(establishment.nEmployees)"
    }
    
    
}


