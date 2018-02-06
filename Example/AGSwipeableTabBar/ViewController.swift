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

    let arrayTitle = ["TableView", "CollectionView", "View", "Button", "Label", "SegmentedController", "switch", "progressView", "Container", "commonView"]
    
    @IBOutlet weak var tabView: AGCommonTabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.detailCollectionView.register(UINib.init(nibName: "TabOneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TabOneCollectionViewCell")
        tabView.delegate = self
//        tabView.numberOfitemInSection = 5
//        tabView.isShowBottomTabBar = true
//        tabView.bottomBarHeight = 2
//        tabView.tabBarData.buttonTitleTextArray = arrayTitle
//        tabView.tabBarData.tabHeader = .title
//        tabView.initialSelectedTab(0)
//        tabView.minimumLineSpacing = 10
//        tabView.minimumCellSpacing = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- ----------FragmentViewController delegate methods----------
    
    func cellForItemForDetailView(atIndex indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabView.detailCollectionView.dequeueReusableCell(withReuseIdentifier: "TabOneCollectionViewCell", for: indexPath) as! TabOneCollectionViewCell
        return cell
    }
    
    func collectionViewCurrentPage(_ currentPage: Int) {
        
    }
}

