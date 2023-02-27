//
//  ReviewsListViewController.swift
//  RaiseCompanyApp
//
//  Created by mei_yocontrolo on 02/02/2023.
//

import UIKit

class ReviewsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var reviewsTable: UITableView!

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        return cell
    }
    


    @IBOutlet weak var reviewsTableView: UITableView!
    

    override func viewDidLoad() {
        print("Incidando reviews")
        super.viewDidLoad()
        reviewsTable.delegate = self
        reviewsTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    
   
    
}
