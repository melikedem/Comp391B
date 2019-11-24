//
//  CitiesDataSource.swift
//  Assignment6
//
//  Created by Apple on 18.11.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import Foundation

protocol CitiesDataSourceDelegate {
    func cityListLoaded (cityList: [City])
    func regionsOfCityLoaded (regionList: [Region])
    func pharmaciesOfRegionLoaded(pharmacyList: [Pharmacy])
    func detailsOfPharmacyLoaded(pharmacy: PharmacyDetail)
}
extension CitiesDataSourceDelegate {
    func cityListLoaded (cityList: [City]){}
    func regionsOfCityLoaded (regionList: [Region]){}
    func pharmaciesOfRegionLoaded(pharmacyList: [Pharmacy]) {}
    func detailsOfPharmacyLoaded(pharmacy: PharmacyDetail){}
}
class CitiesDataSource {
    var delegate: CitiesDataSourceDelegate?
    let baseURL = "https://koc.api.staging.tarentum.io"
    
    func loadListOfCities() {
        let session = URLSession.shared
        
        if let url = URL(string: "\(baseURL)/city") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                            
                let decoder = JSONDecoder()
                let cityList = try! decoder.decode([City].self, from: data!)
                
                DispatchQueue.main.async {
                    self.delegate?.cityListLoaded(cityList: cityList)
                }
            }
            
            dataTask.resume()
        }
    }
    
    func loadRegionsOfCity(cityId: Int) {
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)/city/\(cityId)/region/") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  
            let dataTask = session.dataTask(with: request) { (data, response, error) in
               
                let decoder = JSONDecoder()
                let regionList = try! decoder.decode([Region].self, from: data!)
                
                DispatchQueue.main.async {
                    self.delegate?.regionsOfCityLoaded(regionList: regionList)
                }
            }
            
            dataTask.resume()
        }
    }
    
    func loadPharmaciesOfRegion(regionId: String) {
          let session = URLSession.shared
          if let url = URL(string: "\(baseURL)/region/\(regionId)/pharmacy/") {
              var request = URLRequest(url: url)
              request.httpMethod = "GET"
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
              let dataTask = session.dataTask(with: request) { (data, response, error) in
                 
                  let decoder = JSONDecoder()
                  let pharmacyList = try! decoder.decode([Pharmacy].self, from: data!)
                  
                  DispatchQueue.main.async {
                      self.delegate?.pharmaciesOfRegionLoaded(pharmacyList: pharmacyList)
                  }
              }
              
              dataTask.resume()
          }
      }
    
    func loadPharmacyDetail(pharmacyId: String) {
          let session = URLSession.shared
          if let url = URL(string: "\(baseURL)/pharmacy/\(pharmacyId)") {
              var request = URLRequest(url: url)
              request.httpMethod = "GET"
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
              let dataTask = session.dataTask(with: request) { (data, response, error) in
                 
                  let decoder = JSONDecoder()
                  let pharmacy = try! decoder.decode(PharmacyDetail.self, from: data!)
                  
                  DispatchQueue.main.async {
                      self.delegate?.detailsOfPharmacyLoaded(pharmacy: pharmacy)
                  }
              }
              dataTask.resume()
          }
      }
}
