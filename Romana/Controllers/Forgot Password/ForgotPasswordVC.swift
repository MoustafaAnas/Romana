//
//  ForgotPasswordVC.swift
//  Romana
//
//  Created by Moustafa Anas on 17/01/2022.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var phoneNumbTextFiled: UITextField!
    @IBOutlet weak var nxtBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "نسيت كلمة المرور"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        phoneNumbTextFiled.setPadding()
        
        addIconToTextField(textField: phoneNumbTextFiled, icon: UIImage(systemName: "iphone.homebutton")!)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundImage = UIImage(named: "")
        navigationController?.navigationBar.tintColor = .brown
    }
    
    func addIconToTextField(textField: UITextField, icon: UIImage){
        let leftAddedIcon = UIImageView(frame: CGRect(x: 10.0, y: 0.0, width: icon.size.width, height: icon.size.height))
        leftAddedIcon.image = icon
        leftAddedIcon.tintColor = .brown
        textField.leftViewMode = .always
        let view = UIView(frame: CGRect(x: 0, y: 0, width: icon.size.width, height: icon.size.height))
        view.addSubview(leftAddedIcon)
        textField.leftView = view
        
    }

    @IBAction func continueBtnPressed(_ sender: Any) {
        nxtBtn.isEnabled = false
        phoneNumbTextFiled.isEnabled = false
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CodeActivationVC") as! CodeActivationVC
        navigationController?.pushViewController(vc, animated: true)
        
        phoneNumbTextFiled.text = ""
        phoneNumbTextFiled.isEnabled = true
        nxtBtn.isEnabled = true
    }
    
}
