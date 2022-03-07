//
//  OtherUserMsgCell.swift
//  Romana
//
//  Created by Moustafa Anas on 01/02/2022.
//

import UIKit

class OtherUserMsgCell: UITableViewCell {

    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var msgTimeLbl: UILabel!
    @IBOutlet weak var userMsgLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
