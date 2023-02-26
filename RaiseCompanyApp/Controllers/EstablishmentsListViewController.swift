//
//  EstablishmentsListVC.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 24/01/2023.
//

import UIKit
import Alamofire
import Foundation
import Kingfisher

class EstablishmentListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    public var establishments: [EstablishmentSQLView]?
    
    //filtered establishments will be the data of establishmentsTableView and they will change depending of the searchbar text
    static var filteredEstablishments: [EstablishmentSQLView] = []
    
    //this will exists if an establishment is selected with funciton did selected row at
    var id_establishmentSelected: Int?
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
    //Go to add new establishment
    @IBAction func goToAddEstablishmentBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddEstablishment", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set table view and search bar
        myEstablishmentListTableView.delegate = self
        myEstablishmentListTableView.dataSource = self
        myEstablishmentListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mySearchBar.delegate = self
        
        //Get establishments when this view is open and set the info to the establishment tableview
        ApiManager.shared.getEstablishments { establishments, error in
            if let establishments = establishments {
                self.establishments = establishments
                EstablishmentListViewController.filteredEstablishments = establishments
                self.myEstablishmentListTableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        //quit constrains error from console
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        //if changes of establishments is received... call function to update estalbishments table view
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishment), name: Notification.Name("establishmentAdded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishment), name: Notification.Name("employeeAddedToEstablishment"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishment), name: Notification.Name("establishmentEdited"), object: nil)
        
    }
    
    //Update establishments table view function
    @objc func reloadDataEstablishment(){
        ApiManager.shared.getEstablishments { establishments, error in
            if let establishments = establishments {
                self.establishments = establishments
                EstablishmentListViewController.filteredEstablishments = establishments
                self.myEstablishmentListTableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        self.myEstablishmentListTableView.reloadData()
    }
    
    //return the the filteres establishments
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EstablishmentListViewController.filteredEstablishments.count
    }
    
    //Return each cell with the fields filled in
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EstablishmentTableViewCell
        let establishment = EstablishmentListViewController.filteredEstablishments[indexPath.row]
        cell.location.text = establishment.location
        cell.benefitsLabel.text = "   ▲ \(establishment.benefits!) $" 
        cell.lossesLabel.text = "   ▼ \(establishment.losses!) $"
        cell.numberEmployees.text = "\(establishment.num_employees!) Employees"
        
        //if the establishment has image
        if let strBase64 = establishment.photo, let imageData = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters), let image = UIImage(data: imageData) {
            cell.imgEstablishment.image = image
            //if not set deafult establishment image
        } else {
            cell.imgEstablishment.image = UIImage(named: "defaultEstablishment")
        }
        return cell
    }
    
    // if an establishment has been selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set id_establishmentSelected getting the index path
        id_establishmentSelected = EstablishmentListViewController.filteredEstablishments[indexPath.row].id_establishment!
        performSegue(withIdentifier: "GoEstablishmentDetailedViewController", sender: id_establishmentSelected)
    }
    
    //If cells detects...
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //...delete
        guard editingStyle == .delete else {
            return
        }
        
        //take indexEstablishmentToDelete
        let indexEstablishmentToDelete = indexPath.row
        
        // call delete establishment function with indexEstablishmentToDelete
        ApiManager.shared.deleteEstablishment(indexEstablishmentToDelete: indexEstablishmentToDelete)
        
        // After delete method...
        // Delete from local establishments
        EstablishmentListViewController.filteredEstablishments.remove(at: indexEstablishmentToDelete)
        // Delete the visual row of myEstablishmentListTableView
        self.myEstablishmentListTableView.deleteRows(at: [IndexPath(row: indexEstablishmentToDelete, section: 0)], with: .automatic)
    }
    
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddEstablishment" {
            //pass the function to post establishment
            let addEstablishmnetVC = segue.destination as! AddEstablishmentViewController
        } else if segue.identifier == "GoEstablishmentDetailedViewController"{
            let establishmentDetailVC = segue.destination as! EstablishmentDetailedViewController
            establishmentDetailVC.id_getted = id_establishmentSelected
        }
    }
    
    
}



//search bar function. This will filter the establishments
extension EstablishmentListViewController: UISearchBarDelegate{
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        EstablishmentListViewController.filteredEstablishments = []
        // if searchbar text is empty, filtered establishments are all establishments
        if searchText == ""{
            EstablishmentListViewController.filteredEstablishments = establishments!
        // if is not empety
        } else {
            //Add the establishments to filtered establishments
            for establishment in establishments!{
                if establishment.location.lowercased().contains(searchText.lowercased()){
                    EstablishmentListViewController.filteredEstablishments.append(establishment)
                }
            }
        }
        // recharge data of my myEstablishmentListTableView
        self.myEstablishmentListTableView.reloadData()
    }
}
