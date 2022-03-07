//
//  ReportsVC.swift
//  Romana
//
//  Created by Moustafa Anas on 07/02/2022.
//

import UIKit

class ReportsVC: UIViewController {

    @IBOutlet weak var empolyessCountLbl: UILabel!
    @IBOutlet weak var allBillsForEachIndevLbl: UILabel!
    @IBOutlet weak var allAmountPaidOfMoneyLbl: UILabel!
    @IBOutlet weak var allAmountOfMoneyLeftLbl: UILabel!
    @IBOutlet weak var detailsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "التقارير العامة"
        navigationItem.backButtonTitle = ""
    }

    @IBAction func detailsBtnPressed(_ sender: Any) {
        detailsBtn.isEnabled = false
        
        detailsBtn.isEnabled = true
    }
    

}
