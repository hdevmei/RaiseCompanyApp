//
//  EstablishmentDetailViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 01/02/2023.
//

import Foundation
import UIKit
import Alamofire

class EstablishmentDetailedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var imgEstablishment: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var benefitsLabel: UILabel!
    
    @IBOutlet weak var lossesLabel: UILabel!
    
    @IBOutlet weak var ReviewsContainerVIew: UIView!
    @IBOutlet weak var employeesCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var incidentsContainerView: UIView!
    
    @IBOutlet weak var num_employeesLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var avgRating: UIImageView!
    
    
    
    //The id of the establishment, will always exists because is received from establishment list view controller
    var id_getted: Int?
    
    
    var establishment : EstablishmentSQLView?
    public var employees : [Employee]?
    
    
    var incidencias: [Incident]?
    
    
    
    @IBAction func goToGraphicsView(_ sender: UIButton) {
    }
    
    
    @IBAction func goToEmployeesListBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "GoEmployeesListViewController", sender: nil)
    }
    
    //Segmented control to change between see reviews or incidents
    @IBAction func segmentedControlSelected(_ sender: UISegmentedControl) {
        //see incidents active
        if sender.selectedSegmentIndex == 0 {
            ReviewsContainerVIew.isHidden = true
            incidentsContainerView.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            //see reviews active
            ReviewsContainerVIew.isHidden = false
            incidentsContainerView.isHidden = true
        }
    }
    
    //    override
    override func viewDidLoad() {
        super.viewDidLoad()
        // get establishment from api manager, set to local establishment  and set info
        getEstablishmentAndSetInfo()
        getEmployeesAndSetInfo()
        employeesCollectionView.dataSource = self
        employeesCollectionView.delegate = self
        
        // set segmented control
        ReviewsContainerVIew.isHidden = true
        incidentsContainerView.isHidden = false
        
        //Set observer notificacion after...
        //employee added...
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishmentDetail), name: Notification.Name("employeeAddedToEstablishment"), object: nil)
        //establishment edited
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishmentDetail), name: Notification.Name("establishmentEdited"), object: nil)
    }
    
    //    get request of establishment and employee  and set the info
    @objc func reloadDataEstablishmentDetail(){
        getEstablishmentAndSetInfo()
        getEmployeesAndSetInfo()
    }
    
    func getEstablishmentAndSetInfo(){
        ApiManager.shared.getEstablishment (id_establishment: id_getted!){  establishment, error in
            if let establishment = establishment{
                //convert the establishment getted in the request to local establishment
                self.establishment = establishment
                //set visual info
                self.setInfoEstablishment()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getEmployeesAndSetInfo(){
        ApiManager.shared.getEmployees (id_establishment: id_getted!){employees, error in
            if let employees = employees{
                //convert the employees getted in the request to local employees
                self.employees = employees
                //set visual changes
                DispatchQueue.main.async {
                    self.employeesCollectionView.reloadData()
                    self.employeesCollectionView.dataSource = self
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    //Employee collecition view functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if there are no employees, show 0 cells
        return employees?.count ?? 0
    }
    
    //Give format to each employee cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roundedEmployeeCell", for: indexPath) as! EmployeeCollectionViewCell
        let employee = employees![indexPath.row]
        
        //If image exists set image
        if let strBase64 = employee.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            cell.employeeImage.image = image
            //If image doesn't exists
        } else {
            // Set a default image with a brown background
            cell.employeeImage.image = UIImage(systemName: "person.fill")
        }
        
        cell.nameEmployee.text = (employee.name != nil && employee.lastnames != nil) ? "\(employee.name!) \(employee.lastnames!)" : ""
        return cell
    }
    
    
    // Go to employee detail view
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "GoToEmployeeDetailFromRounded", sender: nil)
//    }
//
    
    //    set info establishment
    func setInfoEstablishment(){
        //if image of establishment exists
        if let strBase64 = self.establishment?.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            imgEstablishment.image = image
            //If image doesn't exists
        } else {
            imgEstablishment.image = UIImage(named: "defaultEstablishment2")
        }
        self.locationLabel.text = self.establishment?.location ?? ""
        self.benefitsLabel.text = "   \(self.establishment?.benefits != nil ? "\(self.establishment!.benefits!)" : "") $"
        self.lossesLabel.text = "   \(self.establishment?.losses != nil ? "\(self.establishment!.losses!)" : "") $"
        self.scheduleLabel.text = self.establishment?.schedule ?? ""
        if self.establishment!.avg_rating != nil{
            self.avgRating.image = UIImage(named: "\(self.establishment!.avg_rating!)rating")
        }
        self.scheduleLabel.text = self.establishment!.schedule
        self.num_employeesLabel.text = "\(self.establishment!.num_employees!) Employees"
    }
    
    
    
    
    
    
    
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoEmployeesListViewController" {
            let EmployeeListVC = segue.destination as! EmployeesListViewController
            EmployeeListVC.id_establishment_selected = id_getted
            //Pass the establishment to put the location and not need to do another get establihsment request
            EmployeeListVC.establishment = establishment
        } else if segue.identifier == "goToEditEstablishment"{
            let editEstablishmentVC = segue.destination as! EditEstablishmentViewController
            editEstablishmentVC.id_establishment_getted = id_getted
        } else if segue.identifier == "IncidentsContainerViewSegue"{
            let incidentsContainerView = segue.destination as! IncidentsViewController
            incidentsContainerView.id_getted = id_getted
        }
    }
    
}
