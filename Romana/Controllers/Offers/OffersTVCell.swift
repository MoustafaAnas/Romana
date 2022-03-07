//
//  OffersTVCell.swift
//  Romana
//
//  Created by Moustafa Anas on 07/02/2022.
//

import UIKit

class OffersTVCell: UITableViewCell {

    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var offerImg: UIImageView!
    @IBOutlet weak var offerEndDateLbl: UILabel!
    @IBOutlet weak var offerPriceLbl: UILabel!
    @IBOutlet weak var offerActivtionStateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
