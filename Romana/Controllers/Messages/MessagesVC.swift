//
//  MessagesVC.swift
//  Romana
//
//  Created by Moustafa Anas on 01/02/2022.
//

import UIKit
import AnimatableReload

class MessagesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var msgsTableView: UITableView!
    @IBOutlet weak var msgContentTxtField: UITextField!
    @IBOutlet weak var btnContainerView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var sendBtnWidthConst: NSLayoutConstraint!
    @IBOutlet weak var containerWidthConst: NSLayoutConstraint!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    
    var chatGroupName: String = ""
    var msgArr = [MsgData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = chatGroupName
        navigationItem.backButtonTitle = ""

        msgContentTxtField.setPadding()
        
        msgsTableView.delegate = self
        msgsTableView.dataSource = self
    
        msgContentTxtField.delegate = self
        
        msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "123456", msgContent: "Hello", msgSentTime: "03:40 PM"))
        msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "12555", msgContent: "any user", msgSentTime: "03:40 PM"))
        msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "123456", msgContent: "current user", msgSentTime: "03:40 PM"))
        msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "12356", msgContent: "nah", msgSentTime: "03:40 PM"))
        msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "12346", msgContent: "asxsaxsaxsaxsaxsaxsaxsaxsaxsaxsaxsaxsaxasxasxsaxsaxsaxasxasxasxsaxsaxsaxsaxsaxsaxsaxsadsadsadqwdqwdwqdwqdwqdwqdqdwqwq", msgSentTime: "03:40 PM"))
        msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "123456", msgContent: "sassaasassasasasasxcsxsxqw", msgSentTime: "03:40 PM"))
        msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "1236", msgContent: "xxxxxxxsaasaswqdwdwq", msgSentTime: "03:40 PM"))

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        configureTableView()
        
        AnimatableReload.reload(tableView: self.msgsTableView, animationDirection: "down")

    }
    
    override open func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(true)
          NotificationCenter.default.removeObserver(self)
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        msgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if msgArr[indexPath.row].userID == "123456" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CurrentUselMsgCell
            cell.msgLbl.text = msgArr[indexPath.row].msgContent
            cell.msgTime.text = msgArr[indexPath.row].msgSentTime
            
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! OtherUserMsgCell
            cell.userProfileImg.image = msgArr[indexPath.row].userProfileImg
            cell.userMsgLbl.text = msgArr[indexPath.row].msgContent
            cell.msgTimeLbl.text = msgArr[indexPath.row].msgSentTime
            
            return cell
        }
    }

    func configureTableView() {
        
        msgsTableView.rowHeight = UITableView.automaticDimension
        msgsTableView.estimatedRowHeight = 120.0
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
 
        UIView.animate(withDuration: 0.5) {
            self.containerWidthConst.constant = 0
            self.btnContainerView.isHidden = true
            self.sendBtnWidthConst.constant = 32
            self.view.layoutIfNeeded()
        }

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.bottomConst.constant = 20
            self.sendBtnWidthConst.constant = 0
            self.containerWidthConst.constant = 70
            self.btnContainerView.isHidden = false
            self.view.layoutIfNeeded()
        }
        
    }


    @IBAction func sendBtnPressed(_ sender: Any) {
        
        sendBtn.isEnabled = false
        msgContentTxtField.isEnabled = false
        
        if msgContentTxtField.text != "" {
            msgArr.append(MsgData(userProfileImg: UIImage(systemName: "person.circle.fill")!, userID: "123456", msgContent: msgContentTxtField.text!, msgSentTime: "03:40 PM"))
        msgContentTxtField.endEditing(true)
        msgContentTxtField.text = ""
        msgsTableView.reloadData()
        self.msgsTableView.scrollToBottom()
            
        }
        else {
            print("no msg")
        }
        
        msgContentTxtField.isEnabled = true
        sendBtn.isEnabled = true
    }
    
    @IBAction func takePicBtnPressed(_ sender: Any) {
        getPhoto(type: .camera)
    }
    
    @IBAction func getPhotoFromAlbuBtnPressed(_ sender: Any) {
        getPhoto(type: .photoLibrary)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("no image")
            return
        }
        
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
    
    private func observeKeyboard() {

    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
    let keyboardHeight = getKeyboardHeight(notification: notification)
        print("\(keyboardHeight)")
        
        UIView.animate(withDuration: 0.5) {
            self.bottomConst.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
       
    }
    
    private func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {return 0}
        return keyboardHeight
    }
    
}

