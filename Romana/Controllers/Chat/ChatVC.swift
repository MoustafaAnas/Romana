//
//  ChatVC.swift
//  Romana
//
//  Created by Moustafa Anas on 22/01/2022.
//

import UIKit
import AnimatableReload

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chatArr = [ChatData]()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatArr.append(ChatData(profilePicture: UIImage(systemName: "message.fill")!, userName: "احمد يوسف", shortMsg: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة", msgSentDate: "١/٥/٢٠٢١", msgIsSeen: false))
        chatArr.append(ChatData(profilePicture: UIImage(systemName: "message.fill")!, userName: "محمد يوسف", shortMsg: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة", msgSentDate: "١/٥/٢٠٢١", msgIsSeen: false))
        chatArr.append(ChatData(profilePicture: UIImage(systemName: "message.fill")!, userName: "احمد حسام", shortMsg: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة", msgSentDate: "١/٥/٢٠٢١", msgIsSeen: true))
        chatArr.append(ChatData(profilePicture: UIImage(systemName: "message.fill")!, userName: "محسن يوسف", shortMsg: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة", msgSentDate: "١/٥/٢٠٢١", msgIsSeen: true))
        chatArr.append(ChatData(profilePicture: UIImage(systemName: "message.fill")!, userName: "احمد اسكندر", shortMsg: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة", msgSentDate: "١/٥/٢٠٢١", msgIsSeen: true))
       
        AnimatableReload.reload(tableView: self.chatTableView, animationDirection: "right")
        
        refreshControlPulled()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "المحادثات"
    }
    
    func refreshControlPulled() {
        refreshControl.tintColor = UIColor.brown
        refreshControl.addTarget(self, action: #selector(refreshVC), for: .valueChanged)
        chatTableView.addSubview(refreshControl)
    }
    @objc func refreshVC() {
        refreshControl.endRefreshing()
        self.chatTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTVCell
        cell.profilePic.image = chatArr[indexPath.row].profilePicture
        cell.userName.text = chatArr[indexPath.row].userName
        cell.msgSentDate.text = chatArr[indexPath.row].msgSentDate
        cell.msgShortcut.text = chatArr[indexPath.row].shortMsg
        
        if chatArr[indexPath.row].msgIsSeen == true {
            cell.msgSeen.isHidden = true
        }
        else {
            cell.msgSeen.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
            navigationController?.pushViewController(vc, animated: true)
            vc.chatGroupName = chatArr[indexPath.row].userName
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

