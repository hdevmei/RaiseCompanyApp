//
//  EstablishmentDetailedViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 16/01/2023.
//

import UIKit

class EstablishmentDetailedViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCollectionViewCell
        
        cell.EmployeeImage.image = UIImage(named: "oasiz")
        return cell
        
    }
    
    var establishment: Establishment!
    
    @IBOutlet weak var employeesCollectionView: UICollectionView!
    @IBOutlet weak var establishmentImage: UIImageView!
    @IBOutlet weak var ReviewsView: UIView!
    @IBOutlet weak var IncidentsView: UIView!
    
    @IBOutlet weak var benefitsAndLossesButton: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var ratingStars: UIImageView!
    @IBOutlet weak var benefitsButton: UIButton!
    
    @IBOutlet weak var lossesButton: UIButton!
    
    @IBOutlet weak var locationName: UILabel!
    
    
    @IBOutlet weak var nEmployeesLabel: UILabel!
    
    
    @IBOutlet weak var graView: UIView!
    
    
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
        
        performSegue(withIdentifier: "GoToGraphicsVC", sender: sender)
        
    }
    
    
    @IBAction func goEmployeesList(_ sender: UIButton) {
        performSegue(withIdentifier: "goToEmployeesList", sender: sender)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeesCollectionView.dataSource = self
    }
    
    
    //
    
    override func viewWillAppear(_ animated: Bool) {
        
        establishmentImage.image = UIImage(named: "\(establishment.image)")
        locationName.text = "\(establishment.location)"
        ratingStars.image = UIImage(named: "\(establishment.rating)rating")
        benefitsButton.setTitle("  ▲ \(establishment.benefits) $", for: .normal)
        lossesButton.setTitle("  ▼ \(establishment.losses) $", for: .normal)
        nEmployeesLabel.text = "\(establishment.nEmployees) Employees"
        print("\(establishment.benefits)")
        //        nEmployees.text = "\(establishment.nEmployees)"
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "GoToGraphicsVC"{
            if let vc = segue.destination as? GraphicsViewController{
                vc.establishment = establishment
            }
        }else if segue.identifier == "goToEmployeesList" {
            if let vc = segue.destination as? EmployeesViewController{
                vc.establishment = establishment
            }
        }
    }
    
    
}


