//
//  AddNewProductVC.swift
//  Romana
//
//  Created by Moustafa Anas on 22/01/2022.
//

import UIKit
import FTIndicator

class AddNewProductVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var productNameTxtField: UITextField!
    @IBOutlet weak var productPriceTxtField: UITextField!
    @IBOutlet weak var productUnitTxtField: UITextField!
    @IBOutlet weak var productQuantTxtField: UITextField!
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var prooductUnitLbl: UILabel!
    @IBOutlet weak var productIdLbl: UILabel!
    @IBOutlet weak var productQuantLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productNamePickerView: UIPickerView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var offeredTotalPriceLbl: UILabel!
    
    var productNameDropDownMenu = ["بيبسي","شيبسي","فيروز","سكر"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "اضافةعرض سعر"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        productNameTxtField.setPadding()
        productPriceTxtField.setPadding()
        productUnitTxtField.setPadding()
        productQuantTxtField.setPadding()
        
        productNameTxtField.delegate = self
        addIconToTextField(textField: productNameTxtField, icon: UIImage(systemName: "arrow.down")!)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        addBtn.isEnabled = false
        productNameTxtField.isEnabled = false
        productPriceTxtField.isEnabled = false
        productQuantTxtField.isEnabled = false
        productUnitTxtField.isEnabled = false
        
        productNameLbl.text = productNameTxtField.text
        productPriceLbl.text = productPriceTxtField.text
        productQuantLbl.text = productQuantTxtField.text
        prooductUnitLbl.text = productUnitTxtField.text
        
        productNameTxtField.isEnabled = true
        productPriceTxtField.isEnabled = true
        productQuantTxtField.isEnabled = true
        productUnitTxtField.isEnabled = true
        addBtn.isEnabled = true
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        confirmBtn.isEnabled = false
        addBtn.isEnabled = false
        FTIndicator.showProgress(withMessage: "")
        
        if productNameLbl.text != "" && productPriceTxtField.text != "" && productQuantTxtField.text != "" && prooductUnitLbl.text != "" {
            
            FTIndicator.showSuccess(withMessage: "تم اضافة المنتج بنجاح")
            navigationController?.popViewController(animated: true)
            
            productNameTxtField.text = ""
            productPriceTxtField.text = ""
            productQuantTxtField.text = ""
            productUnitTxtField.text = ""
        }
        else {
            FTIndicator.showError(withMessage: "يرجي اكمال البيانات لاضافة المنتج")
        }
        addBtn.isEnabled = true
        confirmBtn.isEnabled = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return productNameDropDownMenu.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return productNameDropDownMenu[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.productNameTxtField.text = self.productNameDropDownMenu[row]
        self.productNamePickerView.isHidden = true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.productNameTxtField {
            self.productNamePickerView.isHidden = false
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

}
