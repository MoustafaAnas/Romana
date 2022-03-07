//
//  EmployessVC.swift
//  Romana
//
//  Created by Moustafa Anas on 08/02/2022.
//

import UIKit
import AnimatableReload

class EmployeesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var emplyeesArr = [EmployeesData]()
    
    @IBOutlet weak var employeesTV: UITableView!
    
    @IBOutlet weak var addBtn: UIButton!
    let imgErrorPhoto = UIImageView()
    let errorMsgLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "الموظفون"
        navigationItem.backButtonTitle = ""
        
        employeesTV.delegate = self
        employeesTV.dataSource = self
        
        emplyeesArr.append(EmployeesData(employessName: "محمد حمدي", employeeEmailAddr: "mohamed@gmail.com", employeeAvilableAccess: "الصلاحيــات : المنتجات - المخزون - العروض"))
        emplyeesArr.append(EmployeesData(employessName: "احمد يوسف", employeeEmailAddr: "mohamed@gmail.com", employeeAvilableAccess: "الصلاحيــات : المنتجات - المخزون - العروض"))
        emplyeesArr.append(EmployeesData(employessName: "محمد احمد", employeeEmailAddr: "mohamed@gmail.com", employeeAvilableAccess: "الصلاحيــات : المنتجات - المخزون - العروض"))
        emplyeesArr.append(EmployeesData(employessName: "ادم محمد", employeeEmailAddr: "mohamed@gmail.com", employeeAvilableAccess: "الصلاحيــات : المنتجات - المخزون - العروض"))
        
        AnimatableReload.reload(tableView: self.employeesTV, animationDirection: "left")
        
        noDataToDisplayMsg(tableview: employeesTV, tableViewDataArrCount: emplyeesArr.count)
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        addBtn.isEnabled = false
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddEmployeeVC") as! AddEmployeeVC
        navigationController?.pushViewController(vc, animated: true)
        
        addBtn.isEnabled = true
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emplyeesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeesTVCell
        cell.employeeNameLbl.text = emplyeesArr[indexPath.row].employessName
        cell.employeeEmailAddreLbl.text = emplyeesArr[indexPath.row].employeeEmailAddr
        cell.employessAvilableAccessLbl.text = emplyeesArr[indexPath.row].employeeAvilableAccess
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(cellEditBtnIsPressed), for: .touchUpInside)
        cell.recoredBtn.tag = indexPath.row
        cell.recoredBtn.addTarget(self, action: #selector(cellRecoredBtnIsPressed), for: .touchUpInside)
        
        let maskLayer = CAShapeLayer()
        let bounds = cell.bounds
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 2, y: 2, width: bounds.width-4, height: bounds.height-10), cornerRadius: 5).cgPath
        cell.layer.mask = maskLayer
        
        return cell
    }
    
    @objc func cellEditBtnIsPressed(sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddEmployeeVC") as! AddEmployeeVC
        self.navigationController?.pushViewController(vc, animated: true)
    
        vc.employeeName = emplyeesArr[indexpath.row].employessName
        vc.empEmailAddr = emplyeesArr[indexpath.row].employeeEmailAddr
        vc.empAvilableAccess = emplyeesArr[indexpath.row].employeeAvilableAccess
        vc.empPassword = "123456"
        vc.empPasswordConfim = "123456"
        vc.empPhoneNumber = "010223323332"
    }
    
    @objc func cellRecoredBtnIsPressed(sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        print("\(emplyeesArr[indexpath.row].employessName) Recored")
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
        return 140
    }
    

}


