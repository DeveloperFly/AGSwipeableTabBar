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
    var tabCollectionView: UICollectionView!
    open var detailCollectionView: UICollectionView!
    open var sepratorView = UIView()
    open var tabBottomLayer = CALayer()
    
    //MARK: - Private variablse
    private let agTabViewCellIdentifier = "AGTabViewCollectionViewCell"
    private var isInitialCall = true
    
    //MARK: - Public Variables
    /* tabBarData is used for Set tab Bar Properties
     buttonNormalFontColor
     buttonSelectedFontColor
     buttonTitleTextFont
     buttonTitleTextArray
     
     buttonImageArray
     buttonNormalIconColor
     buttonSelectedIconColor
     tabHeader
     iconTabWidth 
     */
    public var tabBarData: TabButtonData! = TabButtonData.init(tabBarFeturesDictionary: [:])
    
    //Tab CollectionView Properties
    @IBInspectable open var heightTabViewPerportional: CGFloat = 0.07 {
        didSet {
            tabBottomLayer.frame.origin.y = (self.frame.height * heightTabViewPerportional) - tabBottomBarHeight
        }
    }
    
    open var tabViewBottomColor: UIColor? {
        didSet {
            self.tabCollectionView.backgroundColor = tabViewBottomColor ?? UIColor.white
        }
    }
    
    open var tabBarBackgroundColor: CGColor? {
        didSet {
            self.tabBottomLayer.backgroundColor = tabBarBackgroundColor ?? UIColor.blue.cgColor
        }
    }
    
    open var tabViewShowHorizontalScrollIndicator: Bool = false {
        didSet {
            self.tabCollectionView.showsHorizontalScrollIndicator = tabViewShowHorizontalScrollIndicator
        }
    }
    
    var minimumTabLineSpacing: CGFloat = 5 {
        didSet {
        }
    }
    
    var minimumTabCellSpacing: CGFloat = 5 {
        didSet {
        }
    }
    
    @IBInspectable open var tabBottomBarHeight: CGFloat = 5 {
        didSet {
            self.tabBottomLayer.frame.size.height = tabBottomBarHeight
        }
    }
    
    /* By defaul Tab view is equal to screen width
     */
    var isTabViewEqualScreenWidth: Bool = false {
        didSet {
        }
    }
    
    // Detail collectionView Properties
    open var detailViewBottomColor: UIColor? {
        didSet {
            self.detailCollectionView.backgroundColor = detailViewBottomColor ?? UIColor.white
        }
    }
    
    
    //Set number of items in View
    @IBInspectable open var numberOfitemInSection: Int = 2 {
        didSet {
            
        }
    }
    
    //Set intial Selected Tab
    @IBInspectable open var intialSelectedTab: Int = 0 {
        didSet {
        }
    }
    
    //Set tha bottomTabBar is visible or not
    @IBInspectable open var isShowBottomTabBar: Bool = false {
        didSet {
            self.tabBottomLayer.isHidden = !isShowBottomTabBar
        }
    }
    
    //MARK: - Seprator View properties
    //Set seprator view height
    open var sepratorViewHeight: CGFloat = 1 {
        didSet {
            self.sepratorView.frame.size.height = sepratorViewHeight
        }
    }
    
    //Seprator view bottom color
    open var sepratorViewBackgroundColor: UIColor? {
        didSet {
            self.sepratorView.backgroundColor = sepratorViewBackgroundColor
        }
    }
    
    //MARK:- Overloaded Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.tabCollectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * heightTabViewPerportional )
        self.detailCollectionView.frame = CGRect(x: 0, y: ((self.frame.height * heightTabViewPerportional) + sepratorViewHeight), width: self.frame.width, height: (self.frame.height - ((self.frame.height * heightTabViewPerportional) + sepratorViewHeight)))
        sepratorView.frame = CGRect(x: 0, y: (self.frame.height * heightTabViewPerportional), width: self.frame.width, height: sepratorViewHeight)
        tabCollectionView.scrollToItem(at: IndexPath(item: self.intialSelectedTab, section: 0), at: [.centeredHorizontally], animated: false)
        detailCollectionView.scrollToItem(at: IndexPath(item: self.intialSelectedTab, section: 0), at: [.centeredHorizontally], animated: false)
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
        drawSepratorView()
        drawDetailCollectionView()
    }
    
    func drawTabCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: UIScreen.main.bounds.size.height * heightTabViewPerportional )
        self.tabCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        self.tabCollectionView.backgroundColor = tabViewBottomColor
        tabCollectionView.register(AGTabViewCollectionViewCell.self, forCellWithReuseIdentifier: agTabViewCellIdentifier)
        tabCollectionView.showsHorizontalScrollIndicator = tabViewShowHorizontalScrollIndicator
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        configureView()
        self.addSubview(tabCollectionView)
        
    }
    
    func drawSepratorView() {
        sepratorView.frame = CGRect(x: 0, y: (self.frame.height * heightTabViewPerportional), width: self.frame.width, height: sepratorViewHeight)
        sepratorView.backgroundColor = sepratorViewBackgroundColor ?? UIColor.lightGray
        self.addSubview(sepratorView)
    }
    
    func drawDetailCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: ((self.frame.height * heightTabViewPerportional) + sepratorViewHeight), width: self.frame.width, height: (self.frame.height - ((self.frame.height * heightTabViewPerportional) + sepratorViewHeight)))
        self.detailCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        self.detailCollectionView.isPagingEnabled = true
        self.detailCollectionView.delegate = self
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.backgroundColor = detailViewBottomColor
        self.addSubview(detailCollectionView)
    }
    
    fileprivate func configureView() {
        tabBottomLayer.frame = CGRect(x: 0, y: (self.frame.height * heightTabViewPerportional) - tabBottomBarHeight  , width: 0, height: tabBottomBarHeight)
        tabBottomLayer.backgroundColor = tabBarBackgroundColor
        tabCollectionView.layer.addSublayer(tabBottomLayer)
    }
    
    open func initialSelectedTab(index: Int) {
        self.intialSelectedTab = index
        tabCollectionView.selectItem(at: IndexPath.init(item: index, section: 0), animated: true, scrollPosition: [])
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
        let cell = tabCollectionView.dequeueReusableCell(withReuseIdentifier: "AGTabViewCollectionViewCell", for: indexPath) as! AGTabViewCollectionViewCell
        switch  tabBarData.tabHeader {
        case .title:
            cell.setTabTitleViewButtonData(tabBarData, indexPath: indexPath)
        case .icon:
            cell.setTabIconViewButtonData(tabBarData, indexPath: indexPath)
        case .titleAndIcon :
            break
        }
        return cell
    }
    
    func getCell(forDetailCollectionView collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return (delegate?.cellForItemForDetailView(atIndex: indexPath))!
    }
    
}

//MARK:- CollectionView Delegate methods
extension AGCommonTabView: UICollectionViewDelegate {
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(tabCollectionView) {
            tabCollectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
            detailCollectionView.scrollToItem(at: indexPath, at: [], animated: false)
        }
    }
    
}

//MARK:- Collection View DelegateFlowLayout methods
extension AGCommonTabView {
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(tabCollectionView) {
            return 0
        }
        return 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(tabCollectionView) {
            return 0
        }
        return 0
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout Methods
extension AGCommonTabView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(tabCollectionView) {
            switch self.tabBarData.tabHeader {
            case .title:
                if numberOfitemInSection <= 3 || isTabViewEqualScreenWidth {
                    if self.isInitialCall {
                        self.isInitialCall = false
                        tabBottomLayer.frame = CGRect.init(x: CGFloat(CGFloat(self.intialSelectedTab) *  CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)) - 1), y: (self.frame.height * heightTabViewPerportional) - tabBottomBarHeight, width: CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)), height: tabBottomBarHeight)
                        detailCollectionView.scrollToItem(at: IndexPath.init(item: self.intialSelectedTab, section: 0), at: [], animated: false)
                    }
                    return CGSize(width: CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)), height: CGFloat(tabCollectionView.frame.size.height))
                } else {
                    if self.isInitialCall && indexPath.row == self.intialSelectedTab {
                        self.isInitialCall = false
                        let positionX: CGFloat = tabBarData.buttonTitleTextArray.count == 0 ? getWidthForCell(withMessage: "Tab \(indexPath.item + 1)") : CGFloat(getLeadingPointForCell(indexPath: indexPath) + CGFloat(8 * indexPath.row))
                        let poistionY: CGFloat = (self.frame.height * heightTabViewPerportional) - tabBottomBarHeight
                        let widthForFrame: CGFloat = tabBarData.buttonTitleTextArray.count == 0 ? getWidthForCell(withMessage: "Tab \(indexPath.item + 1)") : (getWidthForCell(withMessage: tabBarData.buttonTitleTextArray[indexPath.row]) + 8)
                        let heightForFrame: CGFloat = tabBottomBarHeight
                        tabBottomLayer.frame = CGRect.init(x: positionX, y: poistionY, width: widthForFrame, height: heightForFrame)
                    }
                }
                return CGSize(width: (tabBarData.buttonTitleTextArray.count == 0 ? getWidthForCell(withMessage: "Tab \(indexPath.item + 1)") : getWidthForCell(withMessage: tabBarData.buttonTitleTextArray[indexPath.row])) + 8, height: CGFloat(tabCollectionView.frame.size.height))
                
            case .icon:
                if numberOfitemInSection <= 3 || isTabViewEqualScreenWidth {
                    if self.isInitialCall {
                        self.isInitialCall = false
                        tabBottomLayer.frame = CGRect.init(x: CGFloat(CGFloat(self.intialSelectedTab) *  CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)) - 1), y: (self.frame.height * heightTabViewPerportional) - tabBottomBarHeight, width: CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)), height: tabBottomBarHeight)
                        detailCollectionView.scrollToItem(at: IndexPath.init(item: self.intialSelectedTab, section: 0), at: [], animated: false)
                    }
                    return CGSize(width: CGFloat(Float(tabCollectionView.frame.size.width) / Float(numberOfitemInSection)), height: CGFloat(tabCollectionView.frame.size.height))
                    
                } else {
                    if self.isInitialCall && indexPath.row == self.intialSelectedTab {
                        self.isInitialCall = false
                        let positionX: CGFloat = getLeadingPointForCell(indexPath: indexPath)
                        let poistionY: CGFloat = (self.frame.height * heightTabViewPerportional) - tabBottomBarHeight
                        let widthForFrame: CGFloat = self.tabBarData.iconTabWidth
                        let heightForFrame: CGFloat = tabBottomBarHeight
                        tabBottomLayer.frame = CGRect.init(x: positionX, y:poistionY, width: widthForFrame, height: heightForFrame)
                    }
                }
                return CGSize(width: self.tabBarData.iconTabWidth, height:  CGFloat(tabCollectionView.frame.size.height))
                
            case .titleAndIcon:
                return CGSize(width: self.tabBarData.iconTabWidth , height:  CGFloat(tabCollectionView.frame.size.height))
            }
            
        } else {
            return CGSize(width: UIScreen.main.bounds.width , height: detailCollectionView.frame.size.height)
        }
    }
    
}

//MARK: - UIScrollViewDelegate Methods
extension AGCommonTabView: UIScrollViewDelegate {
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        let indexPath = IndexPath(row: getCurrentPage(), section: 0)
        if (indexPath.row >= 0 && indexPath.row < numberOfitemInSection ) {
            if scrollView == detailCollectionView {
                let cell = tabCollectionView.cellForItem(at: indexPath)
                if cell == nil {
                    return
                }
                let indexPath = IndexPath(row: getCurrentPage(), section: 0)
                if indexPath.row < numberOfitemInSection && indexPath.row >= 0 {
                    tabCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [.centeredHorizontally])
                    callCurrentPageDelegate()
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.tabBottomLayer.frame = CGRect.init(x: (cell?.frame.origin.x)!, y: self.tabCollectionView.frame.size.height - self.tabBottomBarHeight, width: (cell?.frame.size.width)!, height: self.tabBottomBarHeight)
                })
            }
        }
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        print(scrollView.contentOffset)
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //        if scrollView == tabCollectionView {
        //
        //        } else {
        //            let indexPath = IndexPath(row: getCurrentPage(), section: 0)
        //            if indexPath.row < numberOfitemInSection && indexPath.row >= 0 {
        //                tabCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [.centeredHorizontally])
        //                callCurrentPageDelegate()
        //            }
        //        }
        // dismiss keyboard on swipe
        self.endEditing(true)
    }
    
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
    open func callCurrentPageDelegate() {
        if(delegate != nil) {
            delegate?.collectionViewCurrentPage(getCurrentPage())
        }
    }
    
    func getWidthForCell(withMessage message: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17.0)
        
        let attributedText = NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: font])
        let rectSize = CGSize(width: CGFloat(CGFloat.greatestFiniteMagnitude), height: CGFloat(28))
        let rect = attributedText.boundingRect(with: rectSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return ceil(rect.size.width)
    }
    
    func getLeadingPointForCell(indexPath:IndexPath) -> CGFloat {
        if self.tabBarData.tabHeader == .title {
            var leadingPoint: CGFloat = 0.0
            let font = UIFont.systemFont(ofSize: 17.0)
            for index in 0..<indexPath.row {
                let item = self.tabBarData.buttonTitleTextArray[index]
                let attributedText = NSAttributedString(string: item, attributes: [NSAttributedStringKey.font: font])
                let rectSize = CGSize(width: CGFloat(CGFloat.greatestFiniteMagnitude), height: CGFloat(28))
                let rect = attributedText.boundingRect(with: rectSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
                leadingPoint = leadingPoint + ceil(rect.size.width)
            }
            return leadingPoint
        } else {
            let leadingPoint: CGFloat = CGFloat(self.tabBarData.iconTabWidth) * CGFloat(indexPath.row)
            return leadingPoint
        }
    }
    
}

//MARK: - UIView Touch event Delegate Methods
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
