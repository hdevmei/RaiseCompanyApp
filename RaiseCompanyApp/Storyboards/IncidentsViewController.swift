//
//  IncidentsViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 02/02/2023.
//

import UIKit

class IncidentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var incidentsTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incidentCell", for: indexPath)
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        incidentsTable.dataSource = self
        incidentsTable.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
