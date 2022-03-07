//
//  SignUpVC.swift
//  Romana
//
//  Created by Moustafa Anas on 18/01/2022.
//

import UIKit
import FTIndicator

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var haveAccountBtn: UIButton!
    @IBOutlet weak var ccommericalRegBtn: UIButton!
    @IBOutlet weak var licenseBtn: UIButton!
    @IBOutlet weak var companyNameTxtField: UITextField!
    @IBOutlet weak var taxNumberTxtField: UITextField!
    @IBOutlet weak var commRegisterationNoTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    var commericalRegImg: UIImage?
    var licenseImg: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "تسجيل جديد"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        companyNameTxtField.setPadding()
        taxNumberTxtField.setPadding()
        commRegisterationNoTxtField.setPadding()
        phoneNumberTxtField.setPadding()
        emailTxtField.setPadding()
        passwordTxtField.setPadding()
        confirmPasswordTxtField.setPadding()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundImage = UIImage(named: "")
        navigationController?.navigationBar.tintColor = .brown
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func CommercialRegBtnPressed(_ sender: Any) {
        ccommericalRegBtn.isEnabled = false
        showPhotoAlert()

    }
    
    @IBAction func licenseUploadBtnPressed(_ sender: Any) {
        licenseBtn.isEnabled = false
        showPhotoAlert()

    }
    
    
    @IBAction func signupBtnPressed(_ sender: Any) {
        signupBtn.isEnabled = false
        companyNameTxtField.isEnabled = false
        taxNumberTxtField.isEnabled = false
        commRegisterationNoTxtField.isEnabled = false
        phoneNumberTxtField.isEnabled = false
        emailTxtField.isEnabled = false
        passwordTxtField.isEnabled = false
        confirmPasswordTxtField.isEnabled = false
        
        FTIndicator.showProgress(withMessage: "جاري التحميل", userInteractionEnable: false)
        
        let providedEmailAddress = emailTxtField.text
        
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        
        if isEmailAddressValid
        {
            print("Email address is valid")
       
            FTIndicator.showSuccess(withMessage: "سيتم المراجعة وتفعيل الحساب من قبل الإدارة")

            navigationController?.popViewController(animated: true)
            
            companyNameTxtField.text = ""
            taxNumberTxtField.text = ""
            commRegisterationNoTxtField.text = ""
            phoneNumberTxtField.text = ""
            emailTxtField.text = ""
            passwordTxtField.text = ""
            confirmPasswordTxtField.text = ""
            
        }
            
        else {
            print("Email address is not valid")
            FTIndicator.showError(withMessage: "يوجد خطأ في عنوان البريد المدخل", userInteractionEnable: false)
        }
        
        companyNameTxtField.isEnabled = true
        taxNumberTxtField.isEnabled = true
        commRegisterationNoTxtField.isEnabled = true
        phoneNumberTxtField.isEnabled = true
        emailTxtField.isEnabled = true
        passwordTxtField.isEnabled = true
        confirmPasswordTxtField.isEnabled = true
        signupBtn.isEnabled = true
    }
    
    @IBAction func LoginBtnPressed(_ sender: Any) {
        haveAccountBtn.isEnabled = false
        
        navigationController?.popViewController(animated: true)
        
        companyNameTxtField.text = ""
        taxNumberTxtField.text = ""
        commRegisterationNoTxtField.text = ""
        phoneNumberTxtField.text = ""
        emailTxtField.text = ""
        passwordTxtField.text = ""
        confirmPasswordTxtField.text = ""
        haveAccountBtn.isEnabled = true
    }
    
    func showPhotoAlert(){
        let alert = UIAlertController(title: "Take Photo From:", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.getPhoto(type: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            self.getPhoto(type: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.ccommericalRegBtn.isEnabled = true
            self.licenseBtn.isEnabled = true
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("no image")
            return
        }
        
        if ccommericalRegBtn.isEnabled == false {
            commericalRegImg = image
           print("commericalImg")
            ccommericalRegBtn.isEnabled = true
        }
        else if licenseBtn.isEnabled == false {
            licenseImg = image
            print("license")
            licenseBtn.isEnabled = true
        }
      
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.ccommericalRegBtn.isEnabled = true
        self.licenseBtn.isEnabled = true
        dismiss(animated: true, completion: nil)

    }
    
    
    func getPhoto(type: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
}

