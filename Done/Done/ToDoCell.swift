//
//  ToDoCell.swift
//  Done
//
//  Created by Wojtek on 8/14/14.
//  Copyright (c) 2014 Wojtek. All rights reserved.
//

import Foundation
import UIKit

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var textField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        println("ToDo - awakeFromNib")
    }
    
    
    
}