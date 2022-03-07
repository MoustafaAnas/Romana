//
//  BankAccountsVC.swift
//  Romana
//
//  Created by Moustafa Anas on 08/02/2022.
//

import UIKit
import AnimatableReload

class BankAccountsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var BankAccountsTV: UITableView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    var bankAccountArr = [BankAccountData]()
    
    let imgErrorPhoto = UIImageView()
    let errorMsgLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "الحسابات البنكية"
        navigationItem.backButtonTitle = ""
        
        BankAccountsTV.delegate = self
        BankAccountsTV.dataSource = self
        
        bankAccountArr.append(BankAccountData(bankName: "بنك الراجحي", accountNumber: "123456789"))
        bankAccountArr.append(BankAccountData(bankName: "بنك قطر", accountNumber: "123456789"))
        bankAccountArr.append(BankAccountData(bankName: "بنك مصر", accountNumber: "123456789"))
        
        AnimatableReload.reload(tableView: self.BankAccountsTV, animationDirection: "left")
        
        noDataToDisplayMsg(tableview: BankAccountsTV, tableViewDataArrCount: bankAccountArr.count)
    }
    override func viewWillAppear(_ animated: Bool) {
      
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundImage = UIImage(named: "tabBarPic")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bankAccountArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BankAccountsTVCell
        cell.bankNameLbl.text = bankAccountArr[indexPath.row].bankName
        cell.accountNumberLbl.text = bankAccountArr[indexPath.row].accountNumber
        
        let maskLayer = CAShapeLayer()
        let bounds = cell.bounds
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 2, y: 2, width: bounds.width-4, height: bounds.height-10), cornerRadius: 5).cgPath
        cell.layer.mask = maskLayer
        
        return cell
    }
    
    func noDataToDisplayMsg(tableview:UITableView, tableViewDataArrCount: Int) {
        
        imgErrorPhoto.frame = CGRect(x: 50, y: 150, width: self.view.frame.width - 100, height: 200)
        errorMsgLbl.frame = CGRect(x: imgErrorPhoto.frame.minX, y: imgErrorPhoto.frame.maxY + 15, width: imgErrorPhoto.frame.width, height: 30)
        
        if tableViewDataArrCount == 0 {
            tableview.isHidden = true
            imgErrorPhoto.isHidden = false
            errorMsgLbl.isHidden = false
            imgErrorPhoto.image = UIImage(systemName: "icloud.slash")
            imgErrorPhoto.tintColor = UIColor.lightGray
            self.view.addSubview(imgErrorPhoto)
            

            errorMsgLbl.text = "لا يوجد بيانات لعرضها"
            errorMsgLbl.textColor = UIColor.lightGray
            errorMsgLbl.textAlignment = .center
            self.view.addSubview(errorMsgLbl)
        }
        else {
            imgErrorPhoto.isHidden = true
            errorMsgLbl.isHidden = true
            tableview.isHidden = false
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddBankAccountVC") as! AddBankAccountVC
            navigationController?.pushViewController(vc, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "حذف") { action, view, complitionHandler in
            self.bankAccountArr.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            self.noDataToDisplayMsg(tableview: self.BankAccountsTV, tableViewDataArrCount: self.bankAccountArr.count)
            
            complitionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "تعديل") { (_, _, _) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddBankAccountVC") as! AddBankAccountVC
            self.navigationController?.pushViewController(vc, animated: true)
            self.BankAccountsTV.reloadData()
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        editAction.image = UIImage(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        addBtn.isEnabled = false
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddBankAccountVC") as! AddBankAccountVC
        navigationController?.pushViewController(vc, animated: true)
        
        addBtn.isEnabled = true
    }
    

}

