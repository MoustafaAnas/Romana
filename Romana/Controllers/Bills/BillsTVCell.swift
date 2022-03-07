//
//  BillsTVCell.swift
//  Romana
//
//  Created by Moustafa Anas on 28/01/2022.
//

import UIKit

class BillsTVCell: UITableViewCell {

    @IBOutlet weak var processImage: UIImageView!
    @IBOutlet weak var itemsNumber: UILabel!
    @IBOutlet weak var itemID: UILabel!
    @IBOutlet weak var processDate: UILabel!
    @IBOutlet weak var processValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
