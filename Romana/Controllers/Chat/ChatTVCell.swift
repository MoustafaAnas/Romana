//
//  ChatTVCell.swift
//  Romana
//
//  Created by Moustafa Anas on 01/02/2022.
//

import UIKit

class ChatTVCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var msgShortcut: UILabel!
    @IBOutlet weak var msgSeen: UIView!
    @IBOutlet weak var msgSentDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
