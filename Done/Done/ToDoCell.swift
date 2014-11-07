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
    var didTapButtonBlock: (() -> ())!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    func setupView() {
        var imageNormal: UIImage = UIImage(named: "button-done-normal")!
        var imageSelected: UIImage = UIImage(named: "button-done-selected")!
        
        self.doneButton.setImage(imageNormal, forState: UIControlState.Normal)
        self.doneButton.setImage(imageNormal, forState: UIControlState.Disabled)
        self.doneButton.setImage(imageSelected, forState: UIControlState.Selected)
        self.doneButton.setImage(imageSelected, forState: UIControlState.Highlighted)
        self.doneButton.addTarget(self, action: Selector("didTapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didTapButton(button: UIButton) {
        if (self.didTapButtonBlock != nil) {
            self.didTapButtonBlock()
            button.selected = !button.selected
        }
    }
    
    
    
}