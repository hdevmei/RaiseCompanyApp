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
    var filteredEstablishments: [EstablishmentSQLView] = []
    
    var id_establishmentSelected: Int?
    
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
    
    @IBAction func goToAddEstablishmentBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddEstablishment", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myEstablishmentListTableView.delegate = self
        myEstablishmentListTableView.dataSource = self
        myEstablishmentListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mySearchBar.delegate = self
        
        
        ApiManager.shared.getEstablishments { establishments, error in
            if let establishments = establishments {
                self.establishments = establishments
                self.filteredEstablishments = establishments
                self.myEstablishmentListTableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
//        Update establishments from changes of other view controllers
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishment), name: Notification.Name("establishmentAdded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataEstablishment), name: Notification.Name("employeeAddedToEstablishment"), object: nil)
        
    }
    
    //    Update table view after added an establishment
    @objc func reloadDataEstablishment(){
        ApiManager.shared.getEstablishments { establishments, error in
            if let establishments = establishments {
                self.establishments = establishments
                self.filteredEstablishments = establishments
                self.myEstablishmentListTableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        self.myEstablishmentListTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEstablishments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EstablishmentTableViewCell
        let establishment = filteredEstablishments[indexPath.row]
        cell.location.text = establishment.location
        cell.benefitsLabel.text = "   ▲ \(establishment.benefits!) €"
        cell.lossesLabel.text = "   ▲ \(establishment.losses!) €"
        //        cell.imgEstablishment.kf.setImage(with: URL(string: "\(establishment!.photo)"))
        cell.numberEmployees.text = "\(establishment.num_employees) Employees"
        //        cell.rating.image = UIImage(named: "oasiz")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id_establishmentSelected = filteredEstablishments[indexPath.row].id_establishment!
        let location_establishment_selected = filteredEstablishments[indexPath.row].location
        performSegue(withIdentifier: "GoEstablishmentDetailedViewController", sender: id_establishmentSelected)
        
        print("id establishent selected \(id_establishmentSelected!)")
        print(location_establishment_selected)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           guard editingStyle == .delete else {
               return
           }
           
           deleteEstablishment(at: indexPath.row)
       }
    
       
       
       //    URL METHODS
       
       func deleteEstablishment(at index: Int) {
           print("getting estsblishments")
           guard let establishmentId = filteredEstablishments[index].id_establishment else {
               return
           }
           
           let url = "http://127.0.0.1:5000/safari/establishments/\(establishmentId)"
           AF.request(url, method: .delete).response { [weak self] response in
               guard let self = self else {
                   return
               }
               
               switch response.result {
               case .success:
                   self.filteredEstablishments.remove(at: index)
                   self.myEstablishmentListTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
               case .failure(let error):
                   print("Failed to delete employee: \(error)")
               }
           }
           
       }
  
    
    
    
    @IBAction func btnPrueba(_ sender: Any) {
        print(id_establishmentSelected)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAddEstablishment" {
            //               pass the function to post establishment
            let addEstablishmnetVC = segue.destination as! AddEstablishmentViewController
        } else if segue.identifier == "GoEstablishmentDetailedViewController"{
            let establishmentDetailVC = segue.destination as! EstablishmentDetailedViewController
            establishmentDetailVC.id_getted = id_establishmentSelected
        }
    }
}




extension EstablishmentListViewController: UISearchBarDelegate{
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredEstablishments = []
        if searchText == ""{
            filteredEstablishments = establishments!
        } else {
            for establishment in establishments!{
                if establishment.location.lowercased().contains(searchText.lowercased()){
                    filteredEstablishments.append(establishment)
                }
            }
        }
        self.myEstablishmentListTableView.reloadData()
    }
}
