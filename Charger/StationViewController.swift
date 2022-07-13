//
//  StationViewController.swift
//  Charger
//
//  Created by Hakan Pekşen on 6.07.2022.
//

import UIKit

class StationViewController: UIViewController {
    var selectedCity: String?
    @IBOutlet weak var lblResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        
        guard let selectedCity = selectedCity else {
            return
        }
        lblResult.text = "\(String(describing: selectedCity)) şehri için 3 sonuç gösteriliyor"
        }
   

}
