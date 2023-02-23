//
//  EmployeesListViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 04/02/2023.
//

import UIKit
import Alamofire

class EmployeesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var EmployeesCollectionView: UICollectionView!
    
    var id_establishment_selected: Int?
    var establishment : EstablishmentSQLView?
    var employees: [Employee]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getEmployeesOfEstablishment()
        location.text = establishment?.location
        EmployeesCollectionView.delegate = self
        EmployeesCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
                
//        location.text = establishment!.location
        
//         Set notification recevier
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSquareEmployeesCollectionView), name: Notification.Name("employeeAddedToEstablishment"), object: nil)
    }
    
//    UPDATE COLLECTION VIEW AFTER EMPLOYEE ADDED
    @objc func reloadSquareEmployeesCollectionView(){
        print("reload data Square employee")
        getEmployeesOfEstablishment()
        self.EmployeesCollectionView.reloadData()
    }
    
  
    
    @IBAction func AddEmployeeBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GoToAddEmployeeFromEstablishment", sender: nil)

    }
    
    @IBAction func btnDeleteEmployees(_ sender: Any) {
        let cell = SquareEmloyeeCollectionViewCell()
            cell.desactivateDeleteBtn()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.employees?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squareEmployeeCell", for: indexPath) as! SquareEmloyeeCollectionViewCell
        let employee = employees![indexPath.row]
        
        //        If image exists set image
                if let strBase64 = employee.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let imageEmployee = UIImage(data: imageData) {
                    cell.imgEmployee.image = imageEmployee
        //            If image doesn't exists
                       } else {
                           // Set a default image with a brown background
                           cell.imgEmployee.image = UIImage(systemName: "person.fill")
                       }
        
//        Assign values
        var name = ""
        var lastname = ""
        
        name = employee.name != nil ? employee.name! : "No name"
        lastname = employee.lastnames != nil ? employee.lastnames! : "No lastnames"
        let nameAndLastNames = name + " " + lastname
        cell.nameEmployee.text = nameAndLastNames
        cell.salaryEmployee.text = employee.salary != nil ? "\(employee.salary!)" : "Sin salario"
        cell.workPositionEmployee.text = employee.work_position != nil ? "\(employee.work_position!)" : "Sin Puesto"
          return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToEmployeeDetailViewController", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
    

//     URL METHODS
    
    func getEmployeesOfEstablishment(){
        AF.request("http://127.0.0.1:5000/safari/establishments/\(id_establishment_selected!)/employees").responseDecodable(of: [Employee].self) { response in
            self.employees = try? response.result.get()
            self.EmployeesCollectionView.reloadData()
        }
   
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "GoToAddEmployeeFromEstablishment" {
//               pass the function to post establishment
               let addEmployeeVC = segue.destination as! AddEmployeeViewController
               addEmployeeVC.id_establishment_getted = id_establishment_selected
           } else if segue.identifier == "GoToEmployeeDetailFromRounded"{
               let employeeDetailVC = segue.destination as! EmployeeDetailViewController
               employeeDetailVC.id_establishment_getted = id_establishment_selected
           }
       }

}



