//
//  EstablishmentDetailViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 01/02/2023.
//

import Foundation
import UIKit

class EstablishmentDetailedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    //    outlets
    @IBOutlet weak var ReviewsContainerVIew: UIView!
    @IBOutlet weak var employeesCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var incidentsContainerView: UIView!
 
    
    
    @IBAction func goToGraphicsView(_ sender: UIButton) {
        
    }
    
    
    @IBAction func goToEmployeesListBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "GoEmployeesListViewController", sender: nil)
    }
    
    
    
    

    
    
    @IBAction func segmentedControlSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            ReviewsContainerVIew.isHidden = true
            incidentsContainerView.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            ReviewsContainerVIew.isHidden = false
            incidentsContainerView.isHidden = true
        }
    }
    
    
    //    override
    override func viewDidLoad() {
        super.viewDidLoad()
        employeesCollectionView.dataSource = self
        employeesCollectionView.delegate = self
//        set segmented control
        ReviewsContainerVIew.isHidden = true
        incidentsContainerView.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    
    //    Collection view functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roundedEmployeeCell", for: indexPath) as! EmployeeCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        go to detail employee view
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToEmployeeDetailVCfromEstablishment", sender: nil)
    }
    
    
    
    
    
}
