//
//  ViewController.swift
//  Romana
//
//  Created by Moustafa Anas on 17/01/2022.
//

import UIKit
import FTIndicator

class LoginVC: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        //self.overrideUserInterfaceStyle = .light
        
        phoneNumberTextField.setPadding()
        passwordTextField.setPadding()
        
        addIconToTextField(textField: phoneNumberTextField, icon: UIImage(systemName: "iphone.homebutton")!)
        addIconToTextField(textField: passwordTextField, icon: UIImage(systemName: "lock")!)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.isTranslucent = true
        customizeNavBar()
    }
    
    func customizeNavBar () {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundImage =  UIImage(named: "")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    //  navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor =  UIColor(red: 251.0, green: 251.0, blue: 251.0, alpha: 1.0)
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

    @IBAction func forgetPasswordBtnPressed(_ sender: Any) {
        forgotPasswordBtn.isEnabled = false
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        navigationController?.pushViewController(vc, animated: true)
        
        phoneNumberTextField.text = ""
        passwordTextField.text = ""
        forgotPasswordBtn.isEnabled = true
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {

        loginBtn.isEnabled = false
        phoneNumberTextField.isEnabled = false
        passwordTextField.isEnabled = false
        
      FTIndicator.showProgress(withMessage: "جاري التحميل")

        let storyBoard: UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        navigationController?.pushViewController(vc, animated: true)
      //  FTIndicator.dismissProgress()
        
        phoneNumberTextField.text = ""
        passwordTextField.text = ""
        phoneNumberTextField.isEnabled = true
        passwordTextField.isEnabled = true
        loginBtn.isEnabled = true
        
      
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        signupBtn.isEnabled = false
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        navigationController?.pushViewController(vc, animated: true)
        
        phoneNumberTextField.text = ""
        passwordTextField.text = ""
        signupBtn.isEnabled = true
    }
}

