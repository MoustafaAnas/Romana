//
//  AddBankAccountVC.swift
//  Romana
//
//  Created by Moustafa Anas on 08/02/2022.
//

import UIKit

class AddBankAccountVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var bankNameTxtField: UITextField!
    @IBOutlet weak var shopOwnerNameTxtField: UITextField!
    @IBOutlet weak var accountNumberTxtField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var bankNamesPickerView: UIPickerView!
    
    @IBOutlet weak var bankNamesPVHeightConst: NSLayoutConstraint!
    
    var bankNamesDropDownMenu = ["البنك الاهلي","بنك قطر","بنك الراجحي","بنك مصر"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "اضافة حساب بنكي"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        bankNameTxtField.setPadding()
        shopOwnerNameTxtField.setPadding()
        accountNumberTxtField.setPadding()
        
        bankNameTxtField.delegate = self
        addIconToTextField(textField: bankNameTxtField, icon: UIImage(systemName: "arrow.down")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundImage = UIImage(named: "")
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .brown
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return bankNamesDropDownMenu.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return bankNamesDropDownMenu[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.bankNameTxtField.text = self.bankNamesDropDownMenu[row]
        
        UIView.animate(withDuration: 0.1) {
            self.bankNamesPVHeightConst.constant = 0
            self.view.layoutIfNeeded()
        }
      
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.bankNameTxtField {
            
            UIView.animate(withDuration: 0.4) {
                self.bankNamesPVHeightConst.constant = 120
                self.view.layoutIfNeeded()
            }
            
            textField.endEditing(true)
        }
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
    

    @IBAction func addBtnPressed(_ sender: Any) {
        addBtn.isEnabled = false
        bankNameTxtField.isEnabled = false
        shopOwnerNameTxtField.isEnabled = false
        accountNumberTxtField.isEnabled = false
        
        self.navigationController?.popViewController(animated: true)
        
        bankNameTxtField.text = ""
        shopOwnerNameTxtField.text = ""
        accountNumberTxtField.text = ""
        bankNameTxtField.isEnabled = true
        shopOwnerNameTxtField.isEnabled = true
        accountNumberTxtField.isEnabled = true
        addBtn.isEnabled = true
    }
    

}
