//
//  MyProductsVC.swift
//  Romana
//
//  Created by Moustafa Anas on 05/02/2022.
//

import UIKit
import AnimatableReload

class MyProductsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var productTableView: UITableView!
    
    @IBOutlet weak var addNewProductBtn: UIButton!
    
    var productArr = [ProductData]()
    let imgErrorPhoto = UIImageView()
    let errorMsgLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "منتجاتي"
        navigationItem.backButtonTitle = ""
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        productArr.append(ProductData(productImg: UIImage(systemName: "figure.stand")!, ProductName: "بيبسي ٤٥٠ ملل", productExpDate: "Exp. 11 / 2 / 2022", productPrice: "10 SR"))
        productArr.append(ProductData(productImg: UIImage(systemName: "figure.stand")!, ProductName: "بيبسي ٢٥٠ ملل", productExpDate: "Exp. 11 / 2 / 2022", productPrice: "10 SR"))
        productArr.append(ProductData(productImg: UIImage(systemName: "figure.stand")!, ProductName: "كولا ٤٥٠ ملل", productExpDate: "Exp. 11 / 2 / 2022", productPrice: "10 SR"))
        productArr.append(ProductData(productImg: UIImage(systemName: "figure.stand")!, ProductName: "ميرندا ٢٥٠ ملل", productExpDate: "Exp. 11 / 2 / 2022", productPrice: "10 SR"))
        
        AnimatableReload.reload(tableView: self.productTableView, animationDirection: "left")
        
        noDataToDisplayMsg(tableview: productTableView, tableViewDataArrCount: productArr.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyProductTVCell
        cell.productImgView.image = productArr[indexPath.row].productImg
        cell.productName.text = productArr[indexPath.row].ProductName
        cell.expireDate.text = productArr[indexPath.row].productExpDate
        cell.productPrice.text = productArr[indexPath.row].productPrice
        
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
    
    @IBAction func addBtnPressed(_ sender: Any) {
        addNewProductBtn.isEnabled = false
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
        navigationController?.pushViewController(vc, animated: true)
        
        addNewProductBtn.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "حذف") { action, view, complitionHandler in
            self.productArr.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            self.noDataToDisplayMsg(tableview: self.productTableView, tableViewDataArrCount: self.productArr.count)
            
            complitionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "تعديل") { (_, _, _) in

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            self.productTableView.reloadData()
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        editAction.image = UIImage(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

