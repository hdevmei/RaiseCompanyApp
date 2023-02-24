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
    
    
    
    //The id of the establishment, will always exists because is received from establishment detail view controller
    var id_establishment_selected: Int?
    var establishment : EstablishmentSQLView?
    var employees: [Employee]?
    var id_employee_selected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEmployeesAndSetInfo()
        
        //set location label
        location.text = establishment?.location
        
        //Set notification recevier to call the  update collection view function after...
        //...after employee added
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSquareEmployeesCollectionView), name: Notification.Name("employeeAddedToEstablishment"), object: nil)
        // TODO: ...employee deleted

    }
    
    //update employees list
    @objc func reloadSquareEmployeesCollectionView(){
        getEmployeesAndSetInfo()
    }
    
    
    //Go to add new employee
    @IBAction func AddEmployeeBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GoToAddEmployeeFromEstablishment", sender: nil)
    }
    
    @IBAction func btnDeleteEmployees(_ sender: Any) {
        let cell = SquareEmloyeeCollectionViewCell()
        cell.desactivateDeleteBtn()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if there are no employees, show 0 cells
        return self.employees?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squareEmployeeCell", for: indexPath) as! SquareEmloyeeCollectionViewCell
        let employee = employees![indexPath.row]
        //If image exists set image
        if let strBase64 = employee.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let imageEmployee = UIImage(data: imageData) {
            cell.imgEmployee.image = imageEmployee
            //If image doesn't exists
        } else {
            // Set a default image with a brown background
            cell.imgEmployee.image = UIImage(systemName: "person.fill")
        }
        
        // Assign values
        var name = ""
        var lastname = ""
        
        //Use ternary operator to set values
        //...name
        name = employee.name != nil ? employee.name! : "No name"
        //...lastnames
        lastname = employee.lastnames != nil ? employee.lastnames! : "No lastnames"
        
        //Join name and lastnames
        let nameAndLastNames = name + " " + lastname
        cell.nameEmployee.text = nameAndLastNames
        
        //Use ternary operator to set values
        //...name
        //...lastnames
        cell.salaryEmployee.text = employee.salary != nil ? "\(employee.salary!)" : "No salary"
        cell.workPositionEmployee.text = employee.work_position != nil ? "\(employee.work_position!)" : "No work position"
        
        return cell
    }
    
    
    //Go to employee detail view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        id_establishment_selected = employees![indexPath.row].id_employee
        performSegue(withIdentifier: "GoToEmployeeDetailFromSquareList", sender: nil)
        
    }
    
    //Give space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
    
    func getEmployeesAndSetInfo(){
        ApiManager.shared.getEmployees (id_establishment: id_establishment_selected!){employees, error in
            if let employees = employees{
                //convert the employees getted in the request to local employees
                self.employees = employees
                //set visual changes
                DispatchQueue.main.async {
                    self.EmployeesCollectionView.reloadData()
                    self.EmployeesCollectionView.dataSource = self
                    self.EmployeesCollectionView.delegate = self
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Add new employee
        if segue.identifier == "GoToAddEmployeeFromEstablishment" {
            let addEmployeeVC = segue.destination as! AddEmployeeViewController
            addEmployeeVC.id_establishment_getted = id_establishment_selected
            //Go to employee detail view
        } else if segue.identifier == "GoToEmployeeDetailFromRounded"{
            let employeeDetailVC = segue.destination as! EmployeeDetailViewController
            employeeDetailVC.id_employee_getted = id_employee_selected
        }else if segue.identifier == "GoToEmployeeDetailFromSquareList"{
            let employeeDetailVC = segue.destination as! EmployeeDetailViewController
            employeeDetailVC.id_employee_getted = id_establishment_selected
        }
    }
    
}



