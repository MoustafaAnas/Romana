//
//  TabBarVC.swift
//  Romana
//
//  Created by Moustafa Anas on 19/01/2022.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
       
        selectedIndex = 0
        
        setupMiddleButton()
   
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        customizeNavBar()
        
        self.navigationController?.navigationBar.topItem?.title = "الرئيسية"
        navigationItem.backButtonTitle = ""
        self.setupToHideKeyboardOnTapOnView()
    }

//        func addNavBarImage(img: String) {
//
//                let navController = navigationController!
//
//                let image = UIImage(named: img)
//                let imageView = UIImageView(image: image)
//
//                let bannerWidth = navController.navigationBar.frame.size.width
//                let bannerHeight = navController.navigationBar.frame.size.height
//
//                let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
//                let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
//
//                imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
//                imageView.contentMode = .scaleAspectFit
//
//                navigationItem.titleView = imageView
//            }
    
    func customizeNavBar () {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundImage =  UIImage(named: "tabBarPic")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }

    func setupMiddleButton() {

        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
        middleBtn.setImage(UIImage(named: "plus"), for: .normal)
          //add to the tabbar and add click event
           self.tabBar.addSubview(middleBtn)
           middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)

           self.view.layoutIfNeeded()
       }

       // Menu Button Touch Action
       @objc func menuButtonAction(sender: UIButton) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewProductVC") as! AddNewProductVC
           navigationController?.pushViewController(vc, animated: true)
       }


}
