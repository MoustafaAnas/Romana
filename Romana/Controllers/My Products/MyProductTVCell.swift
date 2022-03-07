//
//  MyProductTVCell.swift
//  Romana
//
//  Created by Moustafa Anas on 05/02/2022.
//

import UIKit

class MyProductTVCell: UITableViewCell {

    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
