//
//  AddEmployeeVC.swift
//  Romana
//
//  Created by Moustafa Anas on 09/02/2022.
//

import UIKit

class AddEmployeeVC: UIViewController {

    @IBOutlet weak var employeeNameTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var emailAddrTxtField: UITextField!
    @IBOutlet weak var employeeAccesabilityTxtField: UITextField!
    @IBOutlet weak var employeePasswordTxtField: UITextField!
    @IBOutlet weak var passwordConfirmitionTxtField: UITextField!
    @IBOutlet weak var addEmpBtn: UIButton!
    
    var employeeName: String = ""
    var empPhoneNumber: String = ""
    var empEmailAddr: String = ""
    var empAvilableAccess: String = ""
    var empPassword: String = ""
    var empPasswordConfim: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "اضافة موظف"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        self.overrideUserInterfaceStyle = .light

        setupEmployeeData()
        
        employeeNameTxtField.setPadding()
        phoneNumberTxtField.setPadding()
        emailAddrTxtField.setPadding()
        employeeAccesabilityTxtField.setPadding()
        employeePasswordTxtField.setPadding()
        passwordConfirmitionTxtField.setPadding()
        
        addIconToTextField(textField: employeeAccesabilityTxtField, icon: UIImage(systemName: "arrow.down")!)
    }
    
    func setupEmployeeData() {
        self.employeeNameTxtField.text = employeeName
        self.phoneNumberTxtField.text = empPhoneNumber
        self.emailAddrTxtField.text = empEmailAddr
        self.employeeAccesabilityTxtField.text = empAvilableAccess
        self.employeePasswordTxtField.text = empPassword
        self.passwordConfirmitionTxtField.text = empPasswordConfim
    }
    
    @IBAction func addEmployeeBtnPressed(_ sender: Any) {
        addEmpBtn.isEnabled = false
        employeeNameTxtField.isEnabled = false
        phoneNumberTxtField.isEnabled = false
        emailAddrTxtField.isEnabled = false
        employeeAccesabilityTxtField.isEnabled = false
        employeePasswordTxtField.isEnabled = false
        passwordConfirmitionTxtField.isEnabled = false
        
        self.navigationController?.popViewController(animated: true)
        
        employeeNameTxtField.text = ""
        phoneNumberTxtField.text = ""
        emailAddrTxtField.text = ""
        employeeAccesabilityTxtField.text = ""
        employeePasswordTxtField.text = ""
        passwordConfirmitionTxtField.text = ""
        employeeNameTxtField.isEnabled = true
        phoneNumberTxtField.isEnabled = true
        emailAddrTxtField.isEnabled = true
        employeeAccesabilityTxtField.isEnabled = true
        employeePasswordTxtField.isEnabled = true
        passwordConfirmitionTxtField.isEnabled = true
        addEmpBtn.isEnabled = true
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

}
