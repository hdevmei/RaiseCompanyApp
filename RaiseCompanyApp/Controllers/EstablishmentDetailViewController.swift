//
//  EstablishmentDetailViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 01/02/2023.
//

import Foundation
import UIKit

class EstablishmentDetailedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roundedEmployeeCell", for: indexPath) as! EmployeeCollectionViewCell
        return cell
    }
    
    
    @IBOutlet weak var employeesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeesCollectionView.dataSource = self
        employeesCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
}
