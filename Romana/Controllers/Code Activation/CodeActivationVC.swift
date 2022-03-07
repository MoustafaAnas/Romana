//
//  CodeActivationVC.swift
//  Romana
//
//  Created by Moustafa Anas on 17/01/2022.
//

import UIKit
import FTIndicator

class CodeActivationVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nxtBtn: UIButton!
    @IBOutlet weak var input4: UITextField!
    @IBOutlet weak var input3: UITextField!
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var timerLbl: UILabel!
    
    var codeVerification:String = ""
    var timer: Timer?
    var seenTimer = 59
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "نسيت كلمة المرور"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
        
        input1.delegate = self
        input2.delegate = self
        input3.delegate = self
        input4.delegate = self
         
        input1.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        input2.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        input3.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        input4.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        timerLbl.text = "01:00"
        startTimer()
        
             }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundImage = UIImage(named: "")
        navigationController?.navigationBar.tintColor = .brown
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
               input1.becomeFirstResponder()
    }
    
    func startTimer () {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(codeActivationTimer), userInfo: nil, repeats: true)
    }
    @objc func codeActivationTimer() {

        if seenTimer == 0 {
            navigationController?.popViewController(animated: true)
        }
        else {
            timerLbl.text = "00:\(seenTimer)"
            seenTimer -= 1
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let text = textField.text
        
        if (text?.utf16.count)! >= 1{
            switch textField{
            case input1:
                input2.becomeFirstResponder()
            case input2:
                input3.becomeFirstResponder()
            case input3:
                input4.becomeFirstResponder()
            case input4:
                input4.resignFirstResponder()
                checkingVerification()
            default:
                break
            }
        }else{
            
        }
    }
    
    func checkingVerification() {
        FTIndicator.showProgress(withMessage: "")
        
       codeVerification.append(input1.text!)
       codeVerification.append(input2.text!)
       codeVerification.append(input3.text!)
       codeVerification.append(input4.text!)
       
       if codeVerification == "1234" {
           self.view.endEditing(true)
           
           FTIndicator.showSuccess(withMessage: "")
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewPasswordVC") as? NewPasswordVC
           self.navigationController?.pushViewController(vc!, animated: true)
           
           self.input1.text = ""
           self.input2.text = ""
           self.input3.text = ""
           self.input4.text = ""
           self.codeVerification = ""
           self.input1.becomeFirstResponder()
           seenTimer = 59
           
       }
       else {
           FTIndicator.showError(withMessage: "يوجد خطأ بالكود")
               self.input1.text = ""
               self.input2.text = ""
               self.input3.text = ""
               self.input4.text = ""
               self.codeVerification = ""
               self.input1.becomeFirstResponder()
           
       }
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        nxtBtn.isEnabled = false
        
        checkingVerification()
        
        nxtBtn.isEnabled = true
    }
    
}
