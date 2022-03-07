//
//  HomeTableViewHeader.swift
//  Romana
//
//  Created by Moustafa Anas on 26/01/2022.
//

import UIKit

class HomeTableViewHeader: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var showAllBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showAllBtnPressed(_ sender: Any) {
       
    }
}
