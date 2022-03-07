//
//  MoreVC.swift
//  Romana
//
//  Created by Moustafa Anas on 22/01/2022.
//

import UIKit
import AnimatableReload
import FTIndicator

class MoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var moreTabeView: UITableView!
    
    var moreArr = [MoreData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreTabeView.delegate = self
        moreTabeView.dataSource = self
        
        moreArr.append(MoreData(iconCell: UIImage(systemName: "person.fill")!, titleCell: "الملف الشخصي"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "cube.box.fill")!, titleCell: "منتجاتي"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "aqi.medium")!, titleCell: "العروض"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "rectangle.3.group.fill")!, titleCell: "المخزون"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "banknote.fill")!, titleCell: "الحسابات البنكية"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "person.3.fill")!, titleCell: "الموظفون"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "doc.on.doc.fill")!, titleCell: "التقارير"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "doc.fill")!, titleCell: "السندات"))
        moreArr.append(MoreData(iconCell: UIImage(systemName: "rectangle.trailinghalf.inset.filled.arrow.trailing")!, titleCell: "تسجيل الخروج"))
        
        AnimatableReload.reload(tableView: self.moreTabeView, animationDirection: "right")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "المزيد"
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moreArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoreTVCell
        cell.moreImgCell.image = moreArr[indexPath.row].iconCell
        cell.moreTitleLbl.text = moreArr[indexPath.row].titleCell
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        switch moreArr[indexPath.row].titleCell {
        case "الملف الشخصي":
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            navigationController?.pushViewController(vc, animated: true)
        case "منتجاتي":
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyProductsVC") as! MyProductsVC
            navigationController?.pushViewController(vc, animated: true)
        case "العروض":
            let vc = storyboard?.instantiateViewController(withIdentifier: "OffersVC") as! OffersVC
            navigationController?.pushViewController(vc, animated: true)
        case "المخزون":
            let vc = storyboard?.instantiateViewController(withIdentifier: "StorageVC") as! StorageVC
            navigationController?.pushViewController(vc, animated: true)
        case "الحسابات البنكية":
            let vc = storyboard?.instantiateViewController(withIdentifier: "BankAccountsVC") as! BankAccountsVC
            navigationController?.pushViewController(vc, animated: true)
        case "الموظفون":
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeesVC") as! EmployeesVC
            navigationController?.pushViewController(vc, animated: true)
        case "التقارير":
            let vc = storyboard?.instantiateViewController(withIdentifier: "ReportsVC") as! ReportsVC
            navigationController?.pushViewController(vc, animated: true)
        case "السندات":
            performSegue(withIdentifier: "goToPolicy", sender: self)
        case "تسجيل الخروج":
            FTIndicator.showProgress(withMessage: "", userInteractionEnable: false)
            navigationController?.popToRootViewController(animated: true)
            FTIndicator.showSuccess(withMessage: "تم تسجيل الخروج بنجاح")
            
        default:
            print("def")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

