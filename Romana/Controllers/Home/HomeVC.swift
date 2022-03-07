//
//  HomeVC.swift
//  Romana
//
//  Created by Moustafa Anas on 22/01/2022.
//

import UIKit
import AnimatableReload
import FTIndicator

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
    @IBOutlet weak var homeTableView: UITableView!
    
    var sectionDataArr = [HomeCollectionViewData]()
    var policyTVDataArr = [PolicyTVCellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FTIndicator.showSuccess(withMessage: "تم تسجيل الدخول بنجاح")
        
        homeTableView.delegate = self
        homeTableView.dataSource = self

        sectionDataArr.append(HomeCollectionViewData(sectionName: "أحدث طلبات التوريد", collectionViewData: [HomeCollectionViewCellData(orderName: "12345", orderDate: "1/5/2022", itemsNumber: "123", orderPrice: ""), HomeCollectionViewCellData(orderName: "12345", orderDate: "1/5/2022", itemsNumber: "123", orderPrice: ""), HomeCollectionViewCellData(orderName: "12345", orderDate: "1/5/2022", itemsNumber: "123", orderPrice: "")]))
        
        sectionDataArr.append(HomeCollectionViewData(sectionName: "أحدث الفواتير", collectionViewData: [HomeCollectionViewCellData(orderName: "#12345", orderDate: "1/8/2022", itemsNumber: "123", orderPrice: "١٥٠ ريال"), HomeCollectionViewCellData(orderName: "!12345", orderDate: "1/6/2022", itemsNumber: "123", orderPrice: "١٠٠ ريال"), HomeCollectionViewCellData(orderName: "!12345", orderDate: "1/6/2022", itemsNumber: "123", orderPrice: "١٠٠ ريال"), HomeCollectionViewCellData(orderName: "!12345", orderDate: "1/6/2022", itemsNumber: "123", orderPrice: "١٠٠٠ ريال"), HomeCollectionViewCellData(orderName: "!12345", orderDate: "1/6/2022", itemsNumber: "123", orderPrice: "٢٠٠ ريال")]))
        
        policyTVDataArr.append(PolicyTVCellData(orderPrice: "١٥٠٠ ريال", oderDate: "1/5/2022", orderID: "#123456"))
        policyTVDataArr.append(PolicyTVCellData(orderPrice: "١٥٠٠ ريال", oderDate: "1/5/2022", orderID: "#123456"))
        policyTVDataArr.append(PolicyTVCellData(orderPrice: "١٥٠٠ ريال", oderDate: "1/5/2022", orderID: "#123456"))
        
        AnimatableReload.reload(tableView: self.homeTableView, animationDirection: "right")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "الرئيسية"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            
            return UIView()
        }
        else {
            let headerView = tableView.dequeueReusableCell(withIdentifier: "cell3") as! HomeTableViewHeader
            headerView.showAllBtn.addTarget(self, action: #selector(goToPoliciesVC), for: .touchUpInside)
           return headerView
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 20
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        return sectionDataArr.count
        }
        else {
            return policyTVDataArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CollViewCell
        let data = sectionDataArr[indexPath.row]
        cell.setupCell(title: data.sectionName, cellData: data.collectionViewData)
            
        cell.showAllBtn.tag = indexPath.row
        cell.showAllBtn.addTarget(self, action:#selector(goToBillsVC), for: .touchUpInside)
            
        return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! homeTableViewCell
            cell.orderPrice.text = policyTVDataArr[indexPath.row].orderPrice
            cell.oderDate.text = policyTVDataArr[indexPath.row].oderDate
            cell.orderID.text = policyTVDataArr[indexPath.row].orderID
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
       print("section 0")
           
        }
        else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetalisVC") as! PolicyDetalisVC
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        else {
            return 120
        }
    }
    
    
    @objc func goToBillsVC(sender: UIButton){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        
        if indexpath.row == 0 {
        print("توريد")
        }
        else {
            tabBarController?.selectedIndex = 1
        }
    }
    
    @objc func goToPoliciesVC(sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "PoliciesVC") as! PoliciesVC
        navigationController?.pushViewController(vc, animated: true)

    }
    
   
}

