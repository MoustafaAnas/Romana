//
//  StorageTVCell.swift
//  Romana
//
//  Created by Moustafa Anas on 07/02/2022.
//

import UIKit

class StorageTVCell: UITableViewCell {

    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var minValueLbl: UILabel!
    @IBOutlet weak var storageSlider: UISlider!
    @IBOutlet weak var avgValueLbl: UILabel!
    @IBOutlet weak var maxValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        storageSlider.setThumbImage(UIImage(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
