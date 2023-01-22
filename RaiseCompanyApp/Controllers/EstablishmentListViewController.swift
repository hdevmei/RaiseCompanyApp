//
//  EstablishmentListViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 16/01/2023.
//

import UIKit

class EstablishmentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.filteredEstablishments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let establishmentCell: EstablishmentRow =
        tableView.dequeueReusableCell(withIdentifier: "EstablishmentCell", for: indexPath) as! EstablishmentRow
        
        
        let establishment = DataManager.filteredEstablishments[indexPath.row]
        
        establishmentCell.iamgeEstablishment.image = UIImage(named: establishment.image)
        establishmentCell.location.text = establishment.location
        
        establishmentCell.benefitsBtn.setTitle("  ▲ \(establishment.benefits) $", for: .normal)
        establishmentCell.lossesBtn.setTitle("  ▼ \(establishment.losses) $", for: .normal)
        
        establishmentCell.nEmployees.text = String(establishment.nEmployees) + " Employees"
        establishmentCell.ratingImage.image = UIImage(named: "\(establishment.rating)rating")
        

        
        return establishmentCell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.selectedEstablishment = indexPath.row
            performSegue(withIdentifier: "goToEstablishmentDetailed", sender: DataManager.establishments[indexPath.row])
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mySearchBar.delegate = self
        myEstablishmentsList.delegate = self
        myEstablishmentsList.dataSource = self
//        mySearchBar.searchTextField.backgroundColor = .gray
        DataManager.filteredEstablishments = DataManager.establishments
//        navigationController?.navigationBar.barTintColor = UIColor(red: 0.05, green: 0.16, blue: 0.25, alpha: 1.00)
//        tabBarController?.tabBar.barTintColor = UIColor(red: 0.05, green: 0.16, blue: 0.25, alpha: 1.00)
        // Do any additional setup after loading the view.

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let establishmentDetailedVC = segue.destination as! EstablishmentDetailedViewController
          let establishment = sender as! Establishment
          establishmentDetailedVC.establishment = establishment
      }
 
    
    
    
    
    
    @IBAction func addEstablishmentBtn(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddNewEstablishment") as! UIViewController
        controller.modalPresentationStyle = .automatic
//        controller.modalTransitionStyle = .crossDissolve
                present(controller, animated: true, completion: nil)
       print("Quiero ir a add")
    }
    
    
    @IBOutlet weak var myEstablishmentsList: UITableView!
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    
  
    

}

extension EstablishmentListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DataManager.filteredEstablishments = []
        if searchText == "" {
            DataManager.filteredEstablishments = DataManager.establishments
        } else {
            for establishment in DataManager.establishments {
                if establishment.location.lowercased().contains(searchText.lowercased()){
                    DataManager.filteredEstablishments.append(establishment)
                }
            }
        }
        self.myEstablishmentsList.reloadData()

    }
}


