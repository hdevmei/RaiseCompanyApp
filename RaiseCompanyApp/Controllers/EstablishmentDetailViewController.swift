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
    
    
    var id_getted: Int?
    
    
    var establishment : EstablishmentSQLView?
    public var employees : [Employee]?
    
    
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
        getEstablishment()
        getEmployees()
        employeesCollectionView.dataSource = self
        employeesCollectionView.delegate = self
        
        //        set segmented control
        ReviewsContainerVIew.isHidden = true
        incidentsContainerView.isHidden = false
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishmentDetail), name: Notification.Name("employeeAddedToEstablishment"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishmentDetail), name: Notification.Name("establishmentEdited"), object: nil)
        }
        
    
    @objc func reloadDataEstablishmentDetail(){
        print("Actuliazndo empleados redondos")
        getEmployees()
        self.employeesCollectionView.reloadData()
        getEstablishment()
    }
    

    
    //    Collection view functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employees?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roundedEmployeeCell", for: indexPath) as! EmployeeCollectionViewCell
        
        let employee = employees![indexPath.row]
        
        //        If image exists set image
                if let strBase64 = employee.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
                    cell.employeeImage.image = image
        //            If image doesn't exists
                       } else {
                           // Set a default image with a brown background
                           cell.employeeImage.image = UIImage(systemName: "person.fill")

                       }
        
        cell.nameEmployee.text = (employee.name != nil && employee.lastnames != nil) ? "\(employee.name!) \(employee.lastnames!)" : ""
//        cellEmployee.nameEmployee.text = employee.name != nil ? "\(employee.name!)" : "Sin nombre"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToEmployeeDetailFromRounded", sender: nil)
    }
    
    
//    todooooo
    //    set the views
    func setInfoEstablishment(){
        
        if let strBase64 = self.establishment?.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            imgEstablishment.image = image
//            If image doesn't exists
               } else {
                   imgEstablishment.backgroundColor = .red
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
    
    
    //    URL METHODS
    
    func getEstablishment() {
        AF.request("http://127.0.0.1:5000/safari/establishments/\(id_getted!)")
            .responseDecodable(of: [EstablishmentSQLView].self) { response in
                switch response.result {
                case .success(let establishments):
                    if let firstEstablishment = establishments.first {
                        self.establishment = firstEstablishment
                        DispatchQueue.main.async {
                            self.setInfoEstablishment()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    

    func getEmployees() {
        let url = "http://127.0.0.1:5000/safari/establishments/\(id_getted!)/employees"
               AF.request(url).responseDecodable(of: [Employee].self) { response in
                   switch response.result {
                   case .success(let data):
                           self.employees = data
                           self.employeesCollectionView.reloadData()
                       
                   case .failure(let error):
                       print("Error al obtener los employees: \(error)")
                   }
               }
        employeesCollectionView.reloadData()
        employeesCollectionView.dataSource = self
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "GoEmployeesListViewController" {
//               pass the function to post establishment
               let EmployeeListVC = segue.destination as! EmployeesListViewController
               EmployeeListVC.id_establishment_selected = id_getted
               EmployeeListVC.establishment = establishment
           } else if segue.identifier == "GoEstablishmentDetailedViewController"{
               let establishmentDetailVC = segue.destination as! EstablishmentDetailedViewController
//               establishmentDetailVC.id_getted = id_establishmentSelected
           } else if segue.identifier == "goToEditEstablishment"{
               let editEstablishmentVC = segue.destination as! EditEstablishmentViewController
               editEstablishmentVC.id_establishment_getted = id_getted
           }
       }
    
}
