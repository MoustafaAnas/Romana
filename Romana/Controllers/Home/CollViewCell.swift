//
//  CollViewCell.swift
//  Romana
//
//  Created by Moustafa Anas on 25/01/2022.
//

import UIKit

class CollViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var headrAddr: UILabel!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var showAllBtn: UIButton!
    
    
    var cellDataArr = [HomeCollectionViewCellData]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell (title: String, cellData: [HomeCollectionViewCellData]) {
        self.headrAddr.text = title
        self.cellDataArr = cellData
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if headrAddr.text == "أحدث طلبات التوريد" {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! NewOrdersCell
            cell1.orderNumber.text = cellDataArr[indexPath.row].orderName
            cell1.orderDate.text = cellDataArr[indexPath.row].orderDate
            cell1.itemsNumber.text = cellDataArr[indexPath.row].itemsNumber
            print("section1")
            return cell1
         
        }
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! NewBillsCell
            cell2.orderNumber.text = cellDataArr[indexPath.row].orderName
            cell2.itemsNumber.text = cellDataArr[indexPath.row].itemsNumber
            cell2.orderDate.text = cellDataArr[indexPath.row].orderDate
            cell2.orderPrice.text = cellDataArr[indexPath.row].orderPrice
            
            print("section2")
            return cell2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        if headrAddr.text == "أحدث طلبات التوريد" {
            return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height - 30)
        }
        
        else {
            return CGSize(width: collectionView.frame.width * 0.29, height: collectionView.frame.height - 20)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 20, bottom: 1, right: 20)
    }
}
