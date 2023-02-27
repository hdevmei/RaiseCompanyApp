//
//  IncidentsViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 02/02/2023.
//

import UIKit

class IncidentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var incidentsTable: UITableView!
    var id_getted : Int?
    var incidents: [Incident]?
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incidentCell", for: indexPath)
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Iniciado incidencias")
        incidentsTable.dataSource = self
        incidentsTable.delegate = self
        // Do any additional setup after loading the view.
//        getIncidents()

    }
    
    
    func getIncidents(){
        ApiManager.shared.getIncidentsOfEstablishment (id_establishment: EstablishmentDetailedViewController().id_getted!){incidents, error in
            if let incidents = incidents{
                //convert the employees getted in the request to local employees
                self.incidents = incidents
                self.incidentsTable.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    

   
}
