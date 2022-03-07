//
//  CurrentUselMsgCell.swift
//  Romana
//
//  Created by Moustafa Anas on 01/02/2022.
//

import UIKit

class CurrentUselMsgCell: UITableViewCell {

    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var msgTime: UILabel!
    
  
  override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
