//
//  AddProductVC.swift
//  Romana
//
//  Created by Moustafa Anas on 06/02/2022.
//

import UIKit

class AddProductVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var productParCode: UITextField!
    @IBOutlet weak var productNameTxtField: UITextField!
    @IBOutlet weak var productUnitTxtField: UITextField!
    @IBOutlet weak var productPriceTxtField: UITextField!
    @IBOutlet weak var productExpDateTxtField: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var uploadImgBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "اضافة منتج"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        productParCode.setPadding()
        productNameTxtField.setPadding()
        productUnitTxtField.setPadding()
        productPriceTxtField.setPadding()
        productExpDateTxtField.setPadding()
        
        productExpDateTxtField.delegate = self
        addIconToTextField(textField: productExpDateTxtField, icon: UIImage(systemName: "calendar")!)
        self.productExpDateTxtField.setInputViewDatePicker(target: self, selector: #selector(textFieldTaped))
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        addBtn.isEnabled = false
        productParCode.isEnabled = false
        productNameTxtField.isEnabled = false
        productUnitTxtField.isEnabled = false
        productPriceTxtField.isEnabled = false
        productExpDateTxtField.isEnabled = false
        
        self.navigationController?.popViewController(animated: true)
        
        productParCode.text = ""
        productNameTxtField.text = ""
        productUnitTxtField.text = ""
        productPriceTxtField.text = ""
        productExpDateTxtField.text = ""
        productParCode.isEnabled = true
        productNameTxtField.isEnabled = true
        productUnitTxtField.isEnabled = true
        productPriceTxtField.isEnabled = true
        productExpDateTxtField.isEnabled = true
        addBtn.isEnabled = true
    }
    
    @IBAction func uploadImg(_ sender: Any) {
        getPhoto(type: .photoLibrary)
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
    @objc func textFieldTaped() {
        if let datePicker = self.productExpDateTxtField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.productExpDateTxtField.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.productExpDateTxtField.resignFirstResponder() // 2-5
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("no image")
            return
        }
        
        uploadImgBtn.setImage(image, for: .normal)
        print("upload \(image)")
      
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func getPhoto(type: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

}
