//
//  EmployeesViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 16/01/2023.
//

import UIKit

class EmployeesViewController: UIViewController{
    
    
     
    

    @IBOutlet weak var SquareEmployeesCollectionView: UICollectionView!
    var establishment: Establishment!

    @IBOutlet weak var establishmanetLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SquareEmployeesCollectionView.dataSource = self
        SquareEmployeesCollectionView.delegate = self
//        SquareEmployeesCollectionView.collectionViewLayout = UICollectionViewFlowLayout
//
        
        // Do any additional setup after loading the view.
        establishmanetLocation.text = establishment.location
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




extension EmployeesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquareEmployeeCell", for: indexPath) as! SquareEmployeeCollectionViewCell
        return cell
    }
}



extension EmployeesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = (collectionView.frame.size.width-10)/2
        
        return CGSize(width: widthSize, height: 110)
    }
}
