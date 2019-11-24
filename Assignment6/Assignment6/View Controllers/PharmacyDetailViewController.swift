//
//  PharmacyDetailViewController.swift
//  Assignment6
//
//  Created by Apple on 19.11.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import UIKit

extension PharmacyDetailViewController: CitiesDataSourceDelegate{
    func detailsOfPharmacyLoaded(pharmacy: PharmacyDetail) {
        nameLabel.text = pharmacy.Name
        phoneLabel.text = pharmacy.Phone
        addressLabelTextView.text = pharmacy.Address
    }
}

class PharmacyDetailViewController: UIViewController {
    var selectedPharmacyId: String?
    let citiesDataSource = CitiesDataSource()
    
    @IBOutlet weak var addressLabelTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        citiesDataSource.delegate = self
        citiesDataSource.loadPharmacyDetail(pharmacyId: selectedPharmacyId!)
        
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
