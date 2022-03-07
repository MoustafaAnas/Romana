//
//  PoliciesVC.swift
//  Romana
//
//  Created by Moustafa Anas on 27/01/2022.
//

import UIKit
import AnimatableReload

class PoliciesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var policiesTableView: UITableView!
    var policyCellData = [PolicyTVCellData]()
    let refreshControl = UIRefreshControl()
    let imgErrorPhoto = UIImageView()
    let erorrMsgLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "السندات"
        navigationItem.backButtonTitle = ""
        
        policiesTableView.delegate = self
        policiesTableView.dataSource = self
        
        
        policyCellData.append(PolicyTVCellData(orderPrice: "١٥٠٠ ريال", oderDate: "1/5/2022", orderID: "#123456"))
        policyCellData.append(PolicyTVCellData(orderPrice: "١٥٠٠ ريال", oderDate: "1/5/2022", orderID: "#123456"))
        policyCellData.append(PolicyTVCellData(orderPrice: "١٥٠٠ ريال", oderDate: "1/5/2022", orderID: "#123456"))
        policyCellData.append(PolicyTVCellData(orderPrice: "١٥٠٠ ريال", oderDate: "1/5/2022", orderID: "#123456"))
        
        AnimatableReload.reload(tableView: self.policiesTableView, animationDirection: "left")
        
        refreshControlPulled()

        noDataToDisplayMsg(tableview: policiesTableView, tableViewDataArrCount: policyCellData.count)
    }
    
    func refreshControlPulled() {
        refreshControl.tintColor = UIColor.brown
        refreshControl.addTarget(self, action: #selector(refreshVC), for: .valueChanged)
        policiesTableView.addSubview(refreshControl)
    }
    @objc func refreshVC() {

        refreshControl.endRefreshing()
        self.policiesTableView.reloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return policyCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! homeTableViewCell
        cell.orderPrice.text = policyCellData[indexPath.row].orderPrice
        cell.oderDate.text = policyCellData[indexPath.row].oderDate
        cell.orderID.text = policyCellData[indexPath.row].orderID
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyDetalisVC") as! PolicyDetalisVC
            navigationController?.pushViewController(vc, animated: true)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func noDataToDisplayMsg(tableview:UITableView, tableViewDataArrCount: Int) {
        
        imgErrorPhoto.frame = CGRect(x: 50, y: 150, width: self.view.frame.width - 100, height: 200)
        erorrMsgLbl.frame = CGRect(x: imgErrorPhoto.frame.minX, y: imgErrorPhoto.frame.maxY + 15, width: imgErrorPhoto.frame.width, height: 30)
        
        if tableViewDataArrCount == 0 {
            tableview.isHidden = true
            imgErrorPhoto.isHidden = false
            erorrMsgLbl.isHidden = false
            imgErrorPhoto.image = UIImage(systemName: "icloud.slash")
            imgErrorPhoto.tintColor = UIColor.lightGray
            self.view.addSubview(imgErrorPhoto)
            

            erorrMsgLbl.text = "لا يوجد بيانات لعرضها"
            erorrMsgLbl.textColor = UIColor.lightGray
            erorrMsgLbl.textAlignment = .center
            self.view.addSubview(erorrMsgLbl)
        }
        else {
            imgErrorPhoto.isHidden = true
            erorrMsgLbl.isHidden = true
            tableview.isHidden = false
        }
    }

}
