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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mySearchBar.delegate = self
        myEstablishmentsList.delegate = self
        myEstablishmentsList.dataSource = self
        
        
        
        DataManager.filteredEstablishments = DataManager.establishments
        // Do any additional setup after loading the view.
    }
    

    
    @IBOutlet weak var myEstablishmentsList: UITableView!
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
 

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
