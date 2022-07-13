//
//  StationTableViewCell.swift
//  Charger
//
//  Created by Hakan Pekşen on 10.07.2022.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblStationName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblsocketCount: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
