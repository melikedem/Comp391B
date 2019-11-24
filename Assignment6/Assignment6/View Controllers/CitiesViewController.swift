//
//  ViewController.swift
//  Assignment6
//
//  Created by Apple on 18.11.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import UIKit

extension CitiesViewController: CitiesDataSourceDelegate {
    func cityListLoaded(cityList: [City]) {
            self.citiesArray = cityList
            self.citiesTable.reloadData()
    }
}

extension CitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell
        let index = indexPath.row.quotientAndRemainder(dividingBy: citiesArray.count).remainder
        let city = citiesArray[indexPath.row]
        cell.nameLabel.text = city.Name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cities"
    }
}

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var citiesTable: UITableView!
    let citiesDataSource = CitiesDataSource()
    var citiesArray: [City] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        citiesDataSource.delegate = self
        citiesDataSource.loadListOfCities()
    }

    // MARK: - Navigation
       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           let cell = sender as! CityTableViewCell
           
           let indexPath = citiesTable.indexPath(for: cell)
           
           if let indexPath = indexPath {
            let index = indexPath.row.quotientAndRemainder(dividingBy: citiesArray.count).remainder
               let city = citiesArray[indexPath.row]
               
               let destination = segue.destination as! RegionsViewController
               
                destination.selectedCityId = city.Id
           }
       }
}

