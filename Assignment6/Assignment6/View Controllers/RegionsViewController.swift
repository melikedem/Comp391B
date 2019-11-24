//
//  RegionsViewController.swift
//  Assignment6
//
//  Created by Apple on 19.11.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import UIKit

extension RegionsViewController: CitiesDataSourceDelegate {
    func regionsOfCityLoaded (regionList: [Region]) {
        self.regionsArray = regionList
        self.regionsTable.reloadData()
    }
}

extension RegionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath) as! RegionTableViewCell
        let index = indexPath.row.quotientAndRemainder(dividingBy: regionsArray.count).remainder
        let region = regionsArray[indexPath.row]
        cell.nameLabel.text = region.Name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Regions"
    }
}

class RegionsViewController: UIViewController {
    
    @IBOutlet weak var regionsTable: UITableView!
    var selectedCityId: Int?
    let citiesDataSource = CitiesDataSource()
    var regionsArray: [Region] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        citiesDataSource.delegate = self
        citiesDataSource.loadRegionsOfCity(cityId: selectedCityId!)
    }
    
   // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! RegionTableViewCell
        
        let indexPath = regionsTable.indexPath(for: cell)
        
        if let indexPath = indexPath {
         let index = indexPath.row.quotientAndRemainder(dividingBy: regionsArray.count).remainder
            let region = regionsArray[indexPath.row]
            
            let destination = segue.destination as! PharmaciesViewController
            
            destination.selectedRegionId = region.Id
        }
    }
}
