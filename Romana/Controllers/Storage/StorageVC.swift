//
//  StorageVC.swift
//  Romana
//
//  Created by Moustafa Anas on 07/02/2022.
//

import UIKit
import AnimatableReload

class StorageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var storageTV: UITableView!
    
    var storageArr = [StorageData]()
    let refreshControl = UIRefreshControl()
    let imgErrorPhoto = UIImageView()
    let errorMsgLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "المخزون"
        navigationItem.backButtonTitle = ""
        
        storageTV.delegate = self
        storageTV.dataSource = self
        
        storageArr.append(StorageData(productName: "بيبسي ٢٥٠ ملل", minValue: "30", avgValue: "95", maxValue: "150", currentValue: 100))
        storageArr.append(StorageData(productName: "كولا ٢٥٠ ملل", minValue: "30", avgValue: "95", maxValue: "150", currentValue: 45))
        storageArr.append(StorageData(productName: "شيبسي عائلي", minValue: "30", avgValue: "95", maxValue: "150", currentValue: 150))
        storageArr.append(StorageData(productName: "ميرندا ٢٥٠ ملل", minValue: "30", avgValue: "95", maxValue: "150", currentValue: 95))
        
        AnimatableReload.reload(tableView: self.storageTV, animationDirection: "left")
        
        noDataToDisplayMsg(tableview: storageTV, tableViewDataArrCount: storageArr.count)
        
        refreshControlPulled()
    }
    
    func refreshControlPulled() {
        refreshControl.tintColor = UIColor.brown
        refreshControl.addTarget(self, action: #selector(refreshVC), for: .valueChanged)
        storageTV.addSubview(refreshControl)
    }
    @objc func refreshVC() {
        refreshControl.endRefreshing()
        self.storageTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StorageTVCell
        cell.productNameLbl.text = storageArr[indexPath.row].productName
        cell.minValueLbl.text = storageArr[indexPath.row].minValue
        cell.avgValueLbl.text = storageArr[indexPath.row].avgValue
        cell.maxValueLbl.text = storageArr[indexPath.row].maxValue
        cell.storageSlider.value = storageArr[indexPath.row].currentValue
        
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
        return 120
    }

}


