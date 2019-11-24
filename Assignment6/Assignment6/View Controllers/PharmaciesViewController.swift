//
//  PharmaciesViewController.swift
//  Assignment6
//
//  Created by Apple on 19.11.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import UIKit

extension PharmaciesViewController: CitiesDataSourceDelegate{
    func pharmaciesOfRegionLoaded (pharmacyList: [Pharmacy]) {
        self.pharmaciesArray = pharmacyList
        self.pharmaciesTable.reloadData()
    }
}

extension PharmaciesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmaciesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pharmacyCell", for: indexPath) as! PharmacyTableViewCell
        let index = indexPath.row.quotientAndRemainder(dividingBy: pharmaciesArray.count).remainder
        let pharmacy = pharmaciesArray[indexPath.row]
        cell.nameLabel.text = pharmacy.Name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pharmacies"
    }
}

class PharmaciesViewController: UIViewController {
    
    @IBOutlet weak var pharmaciesTable: UITableView!
    var selectedRegionId: String?
    let citiesDataSource = CitiesDataSource()
    var pharmaciesArray: [Pharmacy] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        citiesDataSource.delegate = self
        citiesDataSource.loadPharmaciesOfRegion(regionId: selectedRegionId!)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! PharmacyTableViewCell
        
        let indexPath = pharmaciesTable.indexPath(for: cell)
        
        if let indexPath = indexPath {
            let pharmacy = pharmaciesArray[indexPath.row]
            
            let destination = segue.destination as! PharmacyDetailViewController
            
            destination.selectedPharmacyId = pharmacy.Id
        }
    }
}
