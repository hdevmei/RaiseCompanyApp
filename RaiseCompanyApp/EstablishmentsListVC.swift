//
//  EstablishmentsListVC.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 24/01/2023.
//

import UIKit



class EstablishmentListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return  4
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          return cell
      }
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var myEstablishmentListTableView: UITableView!
    
    
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           myEstablishmentListTableView.delegate = self
           myEstablishmentListTableView.dataSource = self
           myEstablishmentListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       }
    
    
}
