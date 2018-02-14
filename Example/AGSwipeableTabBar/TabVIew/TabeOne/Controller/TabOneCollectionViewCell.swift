//
//  TabOneCollectionViewCell.swift
//  AGswipeableTabBar
//
//  Created by Aman Gupta on 18/07/17.
//  Copyright © 2017 aman19ish. All rights reserved.
//

import UIKit

class TabOneCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tableViewTabOne: UITableView!
    var indexPathCollectionViewCell: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewTabOne.register(UINib(nibName: "TabOneTableViewCell", bundle: nil), forCellReuseIdentifier: "TabOneTableViewCell")
        tableViewTabOne.delegate = self
        tableViewTabOne.dataSource = self
        tableViewTabOne.estimatedRowHeight = 506.0
        tableViewTabOne.rowHeight = UITableViewAutomaticDimension
        tableViewTabOne.sectionHeaderHeight = 0.0
    }
    
    func configureCell(indexPath: IndexPath) {
        self.indexPathCollectionViewCell = indexPath
    }

}

extension TabOneCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewTabOne.dequeueReusableCell(withIdentifier: "TabOneTableViewCell", for: indexPath) as! TabOneTableViewCell
        cell.configureCell(indexPath, indexPathCollectionCell: indexPathCollectionViewCell)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TabOneCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
