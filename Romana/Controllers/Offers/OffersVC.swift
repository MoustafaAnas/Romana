//
//  OffersVC.swift
//  Romana
//
//  Created by Moustafa Anas on 07/02/2022.
//

import UIKit
import AnimatableReload

class OffersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var offersTV: UITableView!
    
    var offerArr = [OffersData]()
    let imgErrorPhoto = UIImageView()
    let errorMsgLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "العروض"
        navigationItem.backButtonTitle = ""
        
        offersTV.delegate = self
        offersTV.dataSource = self
        
        offerArr.append(OffersData(offerPic: UIImage(systemName: "percent")!, productName: "بيبسي ٢٥٠ ملل", productPrice: "٤", offerEndDate: "٥ / ٥ / ٢٠٢٢", offerActivtionState: "مفعل"))
        offerArr.append(OffersData(offerPic: UIImage(systemName: "percent")!, productName: "بيبسي ٢٥٠ ملل", productPrice: "١٠٠", offerEndDate: "٥ / ٥ / ٢٠٢٢", offerActivtionState: "مفعل"))
        offerArr.append(OffersData(offerPic: UIImage(systemName: "percent")!, productName: "بيبسي ٢٥٠ ملل", productPrice: "٢٠٠", offerEndDate: "٥ / ٥ / ٢٠٢٢", offerActivtionState: "معطل"))
        
        AnimatableReload.reload(tableView: self.offersTV, animationDirection: "left")
        
        noDataToDisplayMsg(tableview: offersTV, tableViewDataArrCount: offerArr.count)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        offerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersTVCell

        cell.offerImg.image = offerArr[indexPath.row].offerPic
        cell.offerEndDateLbl.text = offerArr[indexPath.row].offerEndDate
        cell.offerPriceLbl.text = offerArr[indexPath.row].productPrice
        cell.productNameLbl.text = offerArr[indexPath.row].productName
        cell.offerActivtionStateLbl.text = offerArr[indexPath.row].offerActivtionState
        
        if offerArr[indexPath.row].offerActivtionState == "مفعل" {
            cell.offerActivtionStateLbl.textColor = UIColor.brown
        }
        else {
            cell.offerActivtionStateLbl.textColor = UIColor.darkGray
        }
        
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
        return 100
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "حذف") { action, view, complitionHandler in
            self.offerArr.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            self.noDataToDisplayMsg(tableview: self.offersTV, tableViewDataArrCount: self.offerArr.count)
            
            complitionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "تعديل") { (_, _, _) in
            
            self.editBtnActionSheet(index: indexPath.row)
            
        }

        deleteAction.image = UIImage(systemName: "trash.fill")
        editAction.image = UIImage(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func editBtnActionSheet(index: Int) {
        let alert = UIAlertController(title: "هل تريد تفعيل/تعطيل العرض؟", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "تفعيل", style: .default, handler: { ـ in
            self.offerArr[index].offerActivtionState = "مفعل"
            self.offersTV.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "تعطيل", style: .default, handler: { ـ in
            self.offerArr[index].offerActivtionState = "معطل"
            self.offersTV.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


