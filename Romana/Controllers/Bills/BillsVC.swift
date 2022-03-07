//
//  BillsVC.swift
//  Romana
//
//  Created by Moustafa Anas on 22/01/2022.
//

import UIKit
import AnimatableReload

class BillsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    

    @IBOutlet weak var billsTableView: UITableView!
    @IBOutlet weak var processTypeSC: UISegmentedControl!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var billsVisualEffect: UIVisualEffectView!
    @IBOutlet var editView: UIView!
    @IBOutlet weak var editViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startingDateTextField: UITextField!
    @IBOutlet weak var endingDateTextField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var billsDataArr = [BillsCellData]()
    var buyProcessArr = [BillsCellData]()
    var returnProcessArr = [BillsCellData]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        billsTableView.delegate = self
        billsTableView.dataSource = self
        self.setupToHideKeyboardOnTapOnView()
        
        startingDateTextField.setPadding()
        endingDateTextField.setPadding()
        
        buyProcessArr.append(BillsCellData(processImage: UIImage(systemName: "cart.fill")!, processID: "#123456", processItemsCount: "150", processDate: "1/8/2022", processPriceValue: "18500 ريال"))
        buyProcessArr.append(BillsCellData(processImage: UIImage(systemName: "cart.fill")!, processID: "#123456", processItemsCount: "150", processDate: "1/9/2022", processPriceValue: "18500 ريال"))
        buyProcessArr.append(BillsCellData(processImage: UIImage(systemName: "cart.fill")!, processID: "#123456", processItemsCount: "150", processDate: "1/10/2022", processPriceValue: "18500 ريال"))
        
        returnProcessArr.append(BillsCellData(processImage: UIImage(systemName: "shippingbox.fill")!, processID: "#123456", processItemsCount: "150", processDate: "1/5/2022", processPriceValue: "18500 ريال"))
        returnProcessArr.append(BillsCellData(processImage: UIImage(systemName: "shippingbox.fill")!, processID: "#123456", processItemsCount: "150", processDate: "1/6/2022", processPriceValue: "18500 ريال"))
        returnProcessArr.append(BillsCellData(processImage: UIImage(systemName: "shippingbox.fill")!, processID: "#123456", processItemsCount: "150", processDate: "1/7/2022", processPriceValue: "18500 ريال"))
  
       showTableViewCurrentData()
        
        self.startingDateTextField.setInputViewDatePicker(target: self, selector: #selector(textFieldTaped))
        self.endingDateTextField.setInputViewDatePicker(target: self, selector: #selector(textFieldTaped2))
        
        addIconToTextField(textField: startingDateTextField, icon: UIImage(systemName: "calendar")!)
        addIconToTextField(textField: endingDateTextField, icon: UIImage(systemName: "calendar")!)
        
        AnimatableReload.reload(tableView: self.billsTableView, animationDirection: "down")

        refreshControlPulled()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "الفواتير"
    }
    
    func refreshControlPulled() {
        refreshControl.tintColor = UIColor.brown
        refreshControl.addTarget(self, action: #selector(refreshVC), for: .valueChanged)
        billsTableView.addSubview(refreshControl)
    }
    @objc func refreshVC() {
        refreshControl.endRefreshing()
        self.billsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        billsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BillsTVCell
        cell.processImage.image = billsDataArr[indexPath.row].processImage
        cell.itemsNumber.text = billsDataArr[indexPath.row].processItemsCount
        cell.itemID.text = billsDataArr[indexPath.row].processID
        cell.processDate.text = billsDataArr[indexPath.row].processDate
        cell.processValue.text = billsDataArr[indexPath.row].processPriceValue
        
        
        if billsDataArr[indexPath.row].processImage == buyProcessArr[indexPath.row].processImage {
            cell.processImage.tintColor = UIColor.brown
            cell.processValue.textColor = UIColor.brown
        }
        else {
            cell.processImage.tintColor = UIColor.orange
            cell.processValue.textColor = UIColor.orange
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 85
        
    }
    
    
    @IBAction func processTypeSCChanged(_ sender: Any) {
        processTypeSC.isEnabled = false
        
         showTableViewCurrentData()
        
        processTypeSC.isEnabled = true
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.editViewHeightConstraint.constant = 375
            self.tabBarController?.tabBar.isHidden = true
            self.billsVisualEffect.isHidden = false
            self.view.layoutIfNeeded()
        }


    }
    
    @IBAction func closeEditViewBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.editViewHeightConstraint.constant = 0
            self.tabBarController?.tabBar.isHidden = false
            self.billsVisualEffect.isHidden = true
            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func allBtnPressed(_ sender: Any) {
    }
    @IBAction func confirmBtnPreesed(_ sender: Any) {
        
        confirmBtn.isEnabled = false
        startingDateTextField.isEnabled = false
        endingDateTextField.isEnabled = false
        
        UIView.animate(withDuration: 0.3) {
            self.editViewHeightConstraint.constant = 0
            self.tabBarController?.tabBar.isHidden = false
            self.billsVisualEffect.isHidden = true
            self.view.layoutIfNeeded()
            
        }
        
        startingDateTextField.isEnabled = true
        endingDateTextField.isEnabled = true
        startingDateTextField.text = ""
        endingDateTextField.text = ""
        confirmBtn.isEnabled = true
    }
    
    
    func showTableViewCurrentData () {
        if processTypeSC.selectedSegmentIndex == 0 {
            
            billsDataArr = buyProcessArr
            billsTableView.reloadData()
            AnimatableReload.reload(tableView: self.billsTableView, animationDirection: "right")
            editBtn.isHidden = false
        }
        else {
            billsDataArr = returnProcessArr
            billsTableView.reloadData()
            AnimatableReload.reload(tableView: self.billsTableView, animationDirection: "left")
            editBtn.isHidden = true
        }
    }
    

    
    func addIconToTextField(textField: UITextField, icon: UIImage){
        let leftAddedIcon = UIImageView(frame: CGRect(x: 10.0, y: 0.0, width: icon.size.width, height: icon.size.height))
        leftAddedIcon.image = icon
        leftAddedIcon.tintColor = .brown
        textField.leftViewMode = .always
        let view = UIView(frame: CGRect(x: 0, y: 0, width: icon.size.width, height: icon.size.height))
        view.addSubview(leftAddedIcon)
        textField.leftView = view
        
    }
    
    @objc func textFieldTaped() {
        if let datePicker = self.startingDateTextField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.startingDateTextField.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.startingDateTextField.resignFirstResponder() // 2-5
    }
    
    @objc func textFieldTaped2() {
        if let datePicker = self.endingDateTextField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.endingDateTextField.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.endingDateTextField.resignFirstResponder() // 2-5
    }
}


