//
//  UpdateToDoViewController.swift
//  Done
//
//  Created by Wojtek on 8/13/14.
//  Copyright (c) 2014 Wojtek. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UpdateToDoViewController: UIViewController {
    var record: NSManagedObject!
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel(sender: AnyObject!) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: AnyObject!) {
        var name: String = self.textField.text
        
        if (!name.isEmpty) {
            self.record.setValue(name, forKey: "name")
            
            var error: NSErrorPointer = NSErrorPointer()
            if (self.managedObjectContext.save(error)) {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                UIAlertView(title: "Warning", message: "Unable to save changes", delegate: nil, cancelButtonTitle: "OK").show()
            }
        } else {
            UIAlertView(title: "Warning", message: "Your to-do needs a name", delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.record != nil) {
            self.textField.text = record.valueForKey("name") as String
        }
    }
    
}