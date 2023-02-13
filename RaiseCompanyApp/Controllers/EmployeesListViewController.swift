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

    @IBAction func pruebaBtn(_ sender: Any) {
        print("Desde lista de empleados, este es el id:")
        print(establishment!.location)
        print("Hay una cantidad de: \(employees?.count ?? 0)")

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEmployeesOfEstablishment()

        EmployeesCollectionView.delegate = self
        EmployeesCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
                
        location.text = establishment!.location
    }
    
    
    @IBAction func AddEmployeeBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GoToAddEmployeeFromEstablishment", sender: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.employees?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellEmployee = collectionView.dequeueReusableCell(withReuseIdentifier: "squareEmployeeCell", for: indexPath) as! SquareEmloyeeCollectionViewCell
        let employee = employees![indexPath.row]
        
        cellEmployee.nameEmployee.text = "\(employee.name!)"
        cellEmployee.salaryEmployee.text = "\(employee.salary)"
        cellEmployee.workPositionEmployee.text = "\(employee.work_position!)"
        
        
          return cellEmployee
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToEmployeeDetailViewController", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
    
    func getEmployeesOfEstablishment(){
        AF.request("http://127.0.0.1:5000/safari/establishments/\(id_establishment_selected!)/employees").responseDecodable(of: [Employee].self) { response in
            self.employees = try? response.result.get()
            //            print(response.description)
            print(response.description)
            self.EmployeesCollectionView.reloadData()
        }
   
    }
    
    
    
   
   

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "GoToAddEmployeeFromEstablishment" {
//               pass the function to post establishment
               let addEmployeeVC = segue.destination as! AddEmployeeViewController
               addEmployeeVC.id_getted = id_establishment_selected
           }
       }

}



