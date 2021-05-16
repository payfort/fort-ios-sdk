//
//  TableDataSource.swift
//  
//
//  Created by AlKalouti on 9/2/20.
//  Copyright © 2020 JellyWhale Team. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, Model>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
   
    let cellIdenitfier: String
    var items: [Model]
    
    let configureCell: (CellType, Model, IndexPath) -> ()
    
    init(cellIdenitfier: String, items: [Model], configureCell: @escaping (CellType, Model, IndexPath) -> ()) {
        self.cellIdenitfier = cellIdenitfier
        self.items = items
        self.configureCell = configureCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdenitfier, for: indexPath) as? CellType else {
            fatalError("cell not found")
        }
        
        let vm = items[indexPath.row]
        
        self.configureCell(cell, vm, indexPath)
        
        return cell
    }
    
    func updateItems(_ items: [Model]) {
        self.items = items
    }
}
