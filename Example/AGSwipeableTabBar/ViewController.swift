//
//  ViewController.swift
//  AGSwipeableTabBar
//
//  Created by aman19ish on 01/31/2018.
//  Copyright (c) 2018 aman19ish. All rights reserved.
//

import UIKit
import AGSwipeableTabBar

class ViewController: UIViewController, CommonTabDelegate {
    //MARK: - IBOutlets
    @IBOutlet weak var tabView: AGCommonTabView!
    
    //MARk: - Variables
    let arrayTitle = ["TableView", "CollectionView", "View", "Button", "Label", "SegmentedController", "switch", "progressView", "Container", "commonView"]
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.detailCollectionView.register(UINib.init(nibName: "TabOneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TabOneCollectionViewCell")
        tabView.delegate = self
        tabView.isShowBottomTabBar = true
        tabView.tabBottomBarHeight = 2
        tabView.tabBarBackgroundColor = UIColor.red.cgColor
        tabView.tabBarData.buttonTitleTextArray = arrayTitle
        tabView.tabBarData.tabHeader = .title
        tabView.tabBarData.buttonNormalImageArray = Array.init(repeating: UIImage(named: "homeUnselectdIcon")!, count: tabView.numberOfitemInSection)
        tabView.tabBarData.buttonSelectedImageArray = Array.init(repeating: UIImage(named: "HomeSlectedIcon")!, count: tabView.numberOfitemInSection)
        tabView.tabBarData.buttonSelectedIconColor = UIColor.black
        tabView.tabBarData.buttonNormalFontColor = UIColor.black
        tabView.sepratorViewBackgroundColor = UIColor.green
        tabView.tabBarData.iconTabWidth = 100
        tabView.initialSelectedTab(index: 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- CommonTabDelegate methods
    func cellForItemForDetailView(atIndex indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabView.detailCollectionView.dequeueReusableCell(withReuseIdentifier: "TabOneCollectionViewCell", for: indexPath) as! TabOneCollectionViewCell
        cell.configureCell(indexPath: indexPath)
        return cell
    }
    
    func collectionViewCurrentPage(_ currentPage: Int) {
        
    }
    
}

