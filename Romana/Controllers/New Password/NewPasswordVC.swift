//
//  NewPasswordVC.swift
//  Romana
//
//  Created by Moustafa Anas on 17/01/2022.
//

import UIKit
import FTIndicator

class NewPasswordVC: UIViewController {

    @IBOutlet weak var newPasswordTxtField: UITextField!
    @IBOutlet weak var reenterNewPasswordTxtField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "تغيير كلمة المرور"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        newPasswordTxtField.setPadding()
        reenterNewPasswordTxtField.setPadding()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundImage = UIImage(named: "")
        navigationController?.navigationBar.tintColor = .brown
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        FTIndicator.showProgress(withMessage: "")
        
        saveBtn.isEnabled = false
        newPasswordTxtField.isEnabled = false
        reenterNewPasswordTxtField.isEnabled = false
        
        self.navigationController?.popToRootViewController(animated: true)
        FTIndicator.showSuccess(withMessage: "تم تغيير كلمة المرور بنجاح")
        newPasswordTxtField.text = ""
        reenterNewPasswordTxtField.text = ""
        newPasswordTxtField.isEnabled = true
        reenterNewPasswordTxtField.isEnabled = true
        saveBtn.isEnabled = true
    }
    

}
