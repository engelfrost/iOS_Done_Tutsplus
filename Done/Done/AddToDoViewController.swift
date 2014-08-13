//
//  AddToDoViewController.swift
//  Done
//
//  Created by Wojtek on 8/12/14.
//  Copyright (c) 2014 Wojtek. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddToDoViewController: UIViewController, UITextViewDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel(sender: AnyObject!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject!) {
        var name: String = self.textField.text
        
        if (!name.isEmpty) {
            var entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: self.managedObjectContext)
            var record: NSManagedObject = NSManagedObject(entity: entity, insertIntoManagedObjectContext: self.managedObjectContext)
            
            record.setValue(name, forKey: "name")
            record.setValue(NSDate(), forKey: "createdAt")
            
            var error: NSErrorPointer = NSErrorPointer()
            if (self.managedObjectContext.save(error)) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                UIAlertView(title: "Warning", message: "Unable to save record", delegate: nil, cancelButtonTitle: "OK").show()
            }
            
            
        } else {
            UIAlertView(title: "Warning", message: "Your to-do needs a name", delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
}