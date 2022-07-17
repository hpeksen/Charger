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
    @IBOutlet weak var tableViewStation: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewStation.delegate = self
        tableViewStation.dataSource = self
        tableViewStation.reloadData()
        setUI()
    }
    
    func setUI() {
        
        guard let selectedCity = selectedCity else {
            return
        }
        lblResult.text = "\(String(describing: selectedCity)) şehri için 3 sonuç gösteriliyor"
        //tableViewStation.register(UINib.init(nibName: "StationTableViewCell", bundle: nil), forCellReuseIdentifier: "StationTableViewCell")
        tableViewStation.register(UITableViewCell.self, forCellReuseIdentifier: "StationTableViewCell")
        }
}
extension StationViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.tableViewStation.reloadData()
    }
}
extension StationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //goDetail(city: models[indexPath.row])
    }
}

extension StationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.identifier, for: indexPath) as? StationTableViewCell else{
            return UITableViewCell()
          }
        //let cell = Bundle.main.loadNibNamed(StationTableViewCell.identifier, owner: self, options: nil)?.first as! StationTableViewCell
               
        cell.updateCellWith(imgType: "avatar",lblStationName: "İstanbul", lblTime: "12:12", lblSocketCount: 5, lblDistance: 155)
          return cell
        }
}
