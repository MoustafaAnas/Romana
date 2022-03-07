//
//  ProfileVC.swift
//  Romana
//
//  Created by Moustafa Anas on 12/02/2022.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    
    @IBOutlet weak var staticDataViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var containerDataViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var changeProfilePicBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var profileNavbarView: UIView!
    
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var mobileNumberTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var saveNewPasswordBtn: UIButton!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    
    @IBOutlet weak var savePasswordHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var currentPasswordTxtField: UITextField!
    @IBOutlet weak var newPasswordTxtField: UITextField!
    @IBOutlet weak var confirmNewPasswordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "الملف الشخصي"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        phoneNumberTxtField.setPadding()
        mobileNumberTxtField.setPadding()
        emailTxtField.setPadding()
        passwordTxtField.setPadding()
        locationTxtField.setPadding()
        currentPasswordTxtField.setPadding()
        newPasswordTxtField.setPadding()
        confirmNewPasswordTxtField.setPadding()
        
        editBtn()
        
        addIconToTextField(textField: locationTxtField, icon: UIImage(systemName: "mappin.and.ellipse")!)
        addBtnToTextField(textField: passwordTxtField, title: "تغيير")

        
    }
    

    func editBtn() {
        let editBtn = UIBarButtonItem()
        editBtn.image = UIImage(systemName: "pencil")
        editBtn.action = #selector(editBtnIsPressed)
        editBtn.target = self
        navigationItem.rightBarButtonItem = editBtn
    }
    
   @objc func editBtnIsPressed () {
       UIView.animate(withDuration: 0.4) {
        self.staticDataViewHeightConst.constant = 0
        self.containerDataViewHeightConst.constant = 470
        self.view.layoutIfNeeded()
       }
       phoneNumberTxtField.isEnabled = true
       mobileNumberTxtField.isEnabled = true
       emailTxtField.isEnabled = true
      // passwordTxtField.isEnabled = true
       locationTxtField.isEnabled = true
       self.title = "تعديل الملف الشخصي"
       self.changeProfilePicBtn.isHidden = false
       self.saveBtn.isHidden = false
       self.navigationItem.rightBarButtonItem?.isEnabled = false
       self.navigationItem.rightBarButtonItem?.image = UIImage()
       self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func changeProfilePicBtnIsPressed(_ sender: Any) {
        getPhoto(type: .photoLibrary)
    }
    @IBAction func saveBtnIsPressed(_ sender: Any) {
        saveBtn.isEnabled = false
        
        UIView.animate(withDuration: 0.4) {
         self.staticDataViewHeightConst.constant = 250
         self.containerDataViewHeightConst.constant = 650
         self.view.layoutIfNeeded()
        }
        
        phoneNumberTxtField.isEnabled = false
        mobileNumberTxtField.isEnabled = false
        emailTxtField.isEnabled = false
        //passwordTxtField.isEnabled = false
        locationTxtField.isEnabled = false
        self.title = "الملف الشخصي"
        self.changeProfilePicBtn.isHidden = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "pencil")
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.saveBtn.isHidden = true
        saveBtn.isEnabled = true
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("no image")
            return
        }
        
        self.profileImg.image = image
      
        
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
    
    func addIconToTextField(textField: UITextField, icon: UIImage){
        let leftAddedIcon = UIImageView(frame: CGRect(x: 10.0, y: 0.0, width: icon.size.width, height: icon.size.height))
        leftAddedIcon.image = icon
        leftAddedIcon.tintColor = .brown
        textField.leftViewMode = .always
        let view = UIView(frame: CGRect(x: 0, y: 0, width: icon.size.width, height: icon.size.height))
        view.addSubview(leftAddedIcon)
        textField.leftView = view
        
    }
    
    func addBtnToTextField(textField: UITextField, title: String){
        let button = UIButton(frame: CGRect(x: 10, y: (textField.frame.height)/2 - 5, width: 25, height: 10))
        button.titleLabel?.font =  UIFont(name: "Arial", size: 15)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.brown, for: .normal)
        button.addTarget(self, action: #selector(self.txtFieldBtnAction), for: .touchUpInside)
        textField.leftViewMode = .always
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: textField.frame.height))
        view.addSubview(button)
        textField.leftView = view
    }
    @objc func txtFieldBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.4) {
            self.savePasswordHeightConst.constant = 410
            self.view.layoutIfNeeded()
        }
        visualEffect.isHidden = false
    }
    
    @IBAction func exitNewPasswordBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.4) {
            self.savePasswordHeightConst.constant = 0
            self.view.layoutIfNeeded()
        }
        visualEffect.isHidden = true
    }
    
    @IBAction func saveNewPasswordBtnPressed(_ sender: Any) {
        saveNewPasswordBtn.isEnabled = false
        currentPasswordTxtField.isEnabled = false
        newPasswordTxtField.isEnabled = false
        confirmNewPasswordTxtField.isEnabled = false
        
        UIView.animate(withDuration: 0.4) {
            self.savePasswordHeightConst.constant = 0
            self.view.layoutIfNeeded()
        }
        
            visualEffect.isHidden = true
            currentPasswordTxtField.text = ""
            newPasswordTxtField.text = ""
            confirmNewPasswordTxtField.text = ""
        currentPasswordTxtField.isEnabled = true
        newPasswordTxtField.isEnabled = true
        confirmNewPasswordTxtField.isEnabled = true
        saveNewPasswordBtn.isEnabled = true
    }
    
    
}




