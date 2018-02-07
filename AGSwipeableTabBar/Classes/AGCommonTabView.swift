//
//  AGCommonTabView.swift
//  AGSwipeableTabBar
//
//  Created by Aman Gupta on 06/02/18.
//

import UIKit
import Foundation

public protocol CommonTabDelegate : class {
    func cellForItemForDetailView(atIndex indexPath: IndexPath) -> UICollectionViewCell
    func collectionViewCurrentPage(_ currentPage: Int)
}

//@IBDesignable
open class AGCommonTabView: UIControl {
    open weak var delegate: CommonTabDelegate?

    //MARK: - Custom Views
    open var tabCollectionView: UICollectionView!
    open var detailCollectionView: UICollectionView!
    open var tabBottomLayer = CALayer()

    //MARK: - Variables
    private let agTabViewCellIdentifier = "AGTabViewCollectionViewCell"
    
    @IBInspectable open var heightTabCollectionPerportional: CGFloat = 0.07 {
        didSet {
//            self.tabCollectionView.frame.size.height = UIScreen.main.bounds.size.height * heightTabCollectionPerportional
//            let frame = CGRect(x: 0, y: self.frame.height * heightTabCollectionPerportional, width: self.frame.width, height: (self.frame.size.height - (self.frame.height * heightTabCollectionPerportional)))
//            self.detailCollectionView.frame = frame
            tabBottomLayer.frame.origin.y = (self.frame.height * heightTabCollectionPerportional) - tabBottomBarHeight
        }
    }
    
    @IBInspectable var numberOfitemInSection: Int = 2 {
        didSet {
            
        }
    }
    
    @IBInspectable var minimumLineSpacingTab: CGFloat = 5 {
        didSet {
            
        }
    }
    
    @IBInspectable var minimumCellSpacingTab: CGFloat = 5 {
        didSet {
            
        }
    }
    
    @IBInspectable var tabBottomBarHeight: CGFloat = 5 {
        didSet {
            self.tabBottomLayer.frame.size.height = tabBottomBarHeight
        }
    }
    
    //MARK:- Overloaded Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.tabCollectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * heightTabCollectionPerportional )
        self.detailCollectionView.frame = CGRect(x: 0, y: self.frame.height * heightTabCollectionPerportional, width: self.frame.width, height: (self.frame.height - (self.frame.height * heightTabCollectionPerportional)))
        configureView()
    }
    
    override init(frame: CGRect) {
        // Call super init
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        drawTabCollectionView()
        drawDetailCollectionView()
    }
    
    func drawTabCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: UIScreen.main.bounds.size.height * heightTabCollectionPerportional )
        self.tabCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        self.tabCollectionView.backgroundColor = UIColor.red
        tabCollectionView.register(AGTabViewCollectionViewCell.self, forCellWithReuseIdentifier: agTabViewCellIdentifier)
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        configureView()
        self.addSubview(tabCollectionView)

    }
    
    func drawDetailCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: self.frame.height * heightTabCollectionPerportional, width: self.frame.width, height: (self.frame.height - (self.frame.height * heightTabCollectionPerportional)))
        self.detailCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        self.detailCollectionView.isPagingEnabled = true
        self.detailCollectionView.delegate = self
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.backgroundColor = UIColor.green
        self.addSubview(detailCollectionView)
    }
    
    fileprivate func configureView() {
        tabBottomLayer.frame = CGRect(x: 0, y: (self.frame.height * heightTabCollectionPerportional) - tabBottomBarHeight  , width: 200, height: tabBottomBarHeight)
        tabBottomLayer.backgroundColor = UIColor.blue.cgColor
        tabCollectionView.layer.addSublayer(tabBottomLayer)
    }
    
    //MARK: - Update Methods
    func updateTabCollectionViewHeight() {
   
    }
    
}

//MARK:- CollectionView Data Source methods
extension AGCommonTabView: UICollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfitemInSection
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case tabCollectionView:
            return getCell(forTabCollectionView: collectionView, indexPath: indexPath)
        case detailCollectionView:
            return getCell(forDetailCollectionView: collectionView, indexPath: indexPath)
        default :
            break
        }
        return UICollectionViewCell()
    }
    
    func getCell(forTabCollectionView collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabCollectionView.dequeueReusableCell(withReuseIdentifier: agTabViewCellIdentifier, for: indexPath) as! AGTabViewCollectionViewCell
        return cell
    }
    
    func getCell(forDetailCollectionView collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return (delegate?.cellForItemForDetailView(atIndex: indexPath))!
    }
    
}

extension AGCommonTabView: UICollectionViewDelegate {
    
}

//MARK:- Collection View DelegateFlowLayout methods
extension AGCommonTabView {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(tabCollectionView) {
            return minimumLineSpacingTab
        }
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(tabCollectionView) {
            return minimumCellSpacingTab
        }
        return 0
    }

}

//MARK: - UICollectionViewDelegateFlowLayout Methods
extension AGCommonTabView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabCollectionView {
            return CGSize(width: CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)), height: CGFloat(tabCollectionView.frame.size.height))
        }
        return CGSize(width: self.frame.width , height: detailCollectionView.frame.size.height)
    }
    
}


extension AGCommonTabView: UIScrollViewDelegate {
    
    
    func getCurrentPage() -> Int {
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        return Int(ceilf((Float(detailCollectionView.contentOffset.x) / Float(screenWidth))))
    }
    
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        callCurrentPageDelegate()
    }
}

//MARK:- AGCommonTabView Helper Methods
extension AGCommonTabView {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = IndexPath(row: getCurrentPage(), section: 0)
        if (indexPath.row >= 0 && indexPath.row < numberOfitemInSection ) {
            if scrollView == detailCollectionView {
                let cell = tabCollectionView.cellForItem(at: indexPath)
                if cell == nil {
                    return
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.tabBottomLayer.frame = CGRect.init(x: (cell?.frame.origin.x)!, y: self.tabCollectionView.frame.size.height - 5, width: (cell?.frame.size.width)!, height: self.tabBottomBarHeight)
                })
                //                self.bottomView.frame = CGRect.init(x: , y: self.tabCollectionView.frame.size.height - 5, width: (cell?.frame.size.width)!, height: self.bottomBarHeight)
                
            }
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tabCollectionView {
            
        }else{
            let indexPath = IndexPath(row: getCurrentPage(), section: 0)
            if indexPath.row < numberOfitemInSection && indexPath.row >= 0 {
                tabCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [.centeredHorizontally])
                callCurrentPageDelegate()
            }
        }
        // dismiss keyboard on swipe
        self.endEditing(true)
    }
    open func callCurrentPageDelegate() {
        if(delegate != nil) {
            delegate?.collectionViewCurrentPage(getCurrentPage())
        }
    }
    
    func getWidthForCell(withMessage message: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17.0)

        let attributedText = NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: font  ?? UIFont.systemFont(ofSize: 17.0)])
        let rectSize = CGSize(width: CGFloat(CGFloat.greatestFiniteMagnitude), height: CGFloat(28))
        let rect = attributedText.boundingRect(with: rectSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return ceil(rect.size.width)
    }
    
}


extension AGCommonTabView {
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    open override func cancelTracking(with event: UIEvent?) {
        
    }
    
    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
    }
    
}
