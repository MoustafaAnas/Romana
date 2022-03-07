

import UIKit

class EmployeesTVCell: UITableViewCell {

    @IBOutlet weak var employeeNameLbl: UILabel!
    @IBOutlet weak var employeeEmailAddreLbl: UILabel!
    @IBOutlet weak var employessAvilableAccessLbl: UILabel!
    @IBOutlet weak var recoredBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }

    
}
