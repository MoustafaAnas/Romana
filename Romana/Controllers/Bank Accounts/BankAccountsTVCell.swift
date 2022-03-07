//
//  BankAccountsTVCell.swift
//  Romana
//
//  Created by Moustafa Anas on 08/02/2022.
//

import UIKit

class BankAccountsTVCell: UITableViewCell {

    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var accountNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
